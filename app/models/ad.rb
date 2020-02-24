class Ad < ActiveRecord::Base
  has_many :ad_diffusion_through_playlists
  has_many :playlists, through: :ad_diffusion_through_playlists

  has_many :tags, through: :tagged_resources
  has_many :tagged_resources, as: :taggable_resource, source_type: 'Tag', dependent: :destroy



  validate :name, presence: true
  validates_with UrlValidator


end
