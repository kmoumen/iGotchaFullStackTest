class Playlist < ActiveRecord::Base
  has_many :ad_diffusion_through_playlists
  has_many :ads, through: :ad_diffusion_through_playlists

  has_many :tags, through: :tagged_resources
  has_many :tagged_resources, as: :taggable_resource, source_type: 'Tag', dependent: :destroy

  validate :name, presence: true

  def deploy_tag_to_playlist(tag)

    tagged_ressource = TaggedResource.create(tag_id: tag.id, taggable_resource_id: self.id, taggable_resource_type: self.class.to_s)

    if tagged_ressource.present? && tagged_ressource.valid?
      return_hash = {valid: true, id: tagged_ressource.id }
    else
      return_hash = {valid: false, id: nil }
    end

    return return_hash
  end


  # Accessory function not in requirement added to help in development and testing
  def deploy_tag_to_playlist_with_dates(options = {})

    return {valid: false, id: nil } if (options[:tag].blank? || options[:published_at].blank? || options[:unpublished_at].blank?)
    return {valid: false, id: nil } if (options[:published_at] >= options[:unpublished_at])

    tagged_ressource = TaggedResource.create(tag_id: options[:tag].id,
                                            taggable_resource_id: self.id,
                                            taggable_resource_type: self.class.to_s,
                                            published_at: options[:published_at],
                                            unpublished_at: options[:unpublished_at]
                                            )

    if tagged_ressource.present? && tagged_ressource.valid?
      return_hash = {valid: true, id: tagged_ressource.id }
    else
      return_hash = {valid: false, id: nil }
    end

    return return_hash
  end


  def deployed_media_on(date)
    deployed_medias(date)
  end


  def deployed_medias(date = nil)

    deployed_media = []
    deployed_media_hash = {}

    # Ads directly in playlist
    playlist_ads_by_diffusion_assoc = self.ads
    playlist_ads_by_diffusion_assoc.each {|ad| deployed_media_hash[ad.id] = ad.name }

    # Ads via Tags
    if date.present?
      playlist_tags_ids = self.tagged_resources.published_at(date).pluck(:tag_id)
    else
      playlist_tags_ids = self.tagged_resources.pluck(:tag_id)
    end

    ads_tagged_by_playlist_tags = TaggedResource.where(tag_id: playlist_tags_ids, taggable_resource_type: "Ad")

    our_tags_ids = ads_tagged_by_playlist_tags.pluck(:taggable_resource_id)
    our_concerned_ads = Ad.where(id: our_tags_ids)

    our_concerned_ads.each {|ad| deployed_media_hash[ad.id] = ad.name}

    # Construct the final ads names table
    deployed_media_hash.keys.sort.each {|id| deployed_media << deployed_media_hash[id]}

    return deployed_media
  end

end
