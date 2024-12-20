module FullNameable
  extend ActiveSupport::Concern

  NAME_SEPARATOR = ' '.freeze

  def full_name
    [name, surname].compact.join(NAME_SEPARATOR)
  end
end
