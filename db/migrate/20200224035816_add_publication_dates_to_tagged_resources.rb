class AddPublicationDatesToTaggedResources < ActiveRecord::Migration
  def change
    add_column :tagged_resources, :published_at  , :datetime, default: nil
    add_column :tagged_resources, :unpublished_at, :datetime, default: nil
  end
end
