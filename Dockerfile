FROM ruby:3.3.5

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  git \
  libpq-dev \
  postgresql-client \
  libvips \
  nodejs \
  npm \
  && npm install -g yarn@1.22.22 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV BUNDLE_PATH=/usr/local/bundle
ENV NODE_OPTIONS=--openssl-legacy-provider

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.5.16
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY . .

COPY docker/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["bash", "-lc", "bundle exec rails server -b 0.0.0.0"]
