# README

## Docker

### Build images

```bash
docker compose build
```

### Start application

```bash
docker compose up
```

### Start application in background

```bash
docker compose up -d
```

### Stop containers

```bash
docker compose down
```

---

### Run migrations

```bash
docker compose exec web bundle exec rails db:migrate
```

### Run seeds

```bash
docker compose exec web bundle exec rails db:seed
```

### Run tests

```bash
docker compose exec web bundle exec rspec
```
---
### Open Rails console

```bash
docker compose exec web bundle exec rails console
```
---
### Run RuboCop check

```bash
docker compose exec web bundle exec rubocop
```

### Run RuboCop check for a specific file or folder

```bash
docker compose exec web bundle exec rubocop app/models/user.rb
```

### Run safe RuboCop autocorrect

```bash
docker compose exec web bundle exec rubocop -a
```

### Run unsafe RuboCop autocorrect

```bash
docker compose exec web bundle exec rubocop -A
```

### Autocorrect a single specific RuboCop cop

```bash
docker compose exec web bundle exec rubocop -a --only Style/FrozenStringLiteralComment
```
---
### Run ERBLint check

```bash
docker compose exec web bundle exec erblint --lint-all
```

### Run ERBLint autocorrect

```bash
docker compose exec web bundle exec erblint -la -a
```

---

## Commands when containers are not running

Use `docker compose run --rm` when the `web` container is not already running.

---

## Seeded demo user credentials

| Role | Email | Password |
| --- | --- | --- |
| Instructor | instructor@mail.com | Test123! |
| Instructor admin | instructor_admin@mail.com | Test123! |
| Student | student@mail.com | Test123! |
