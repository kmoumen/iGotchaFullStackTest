class Tag < ActiveRecord::Base
  validate :name, presence: true
end
