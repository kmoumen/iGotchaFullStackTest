class TaggedResource < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggaable_resource, polymorphic: true

  validates_with PublicationValidator
  scope :published_at, -> (given_date){ where("(#{self.table_name}.published_at < ? AND #{self.table_name}.unpublished_at > ?)",
                                              *[given_date]*2) }
end
