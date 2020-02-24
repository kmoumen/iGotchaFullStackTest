class AdDiffusionThroughPlaylist < ActiveRecord::Base
  belongs_to :ad
  belongs_to :playlist
end
