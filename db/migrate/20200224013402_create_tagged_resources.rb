class CreateTaggedResources < ActiveRecord::Migration
  def change
    create_table :tagged_resources do |t|
      t.belongs_to :tag
      t.references :taggable_resource, polymorphic: true

      t.timestamps
    end
  end
end
