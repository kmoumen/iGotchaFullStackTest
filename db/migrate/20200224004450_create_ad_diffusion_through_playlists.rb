class CreateAdDiffusionThroughPlaylists < ActiveRecord::Migration
  def change
    create_table :ad_diffusion_through_playlists do |t|
      t.belongs_to :ad
      t.belongs_to :playlist

      t.timestamps
    end
  end
end
