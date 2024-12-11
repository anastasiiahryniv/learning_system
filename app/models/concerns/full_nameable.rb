module FullNameable
  extend ActiveSupport::Concern

  NAME_SEPARATOR = ' '.freeze

  def full_name
    [object.name, object.surname].compact.join(NAME_SEPARATOR)
  end
end
