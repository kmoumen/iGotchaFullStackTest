namespace :db_seed do
  task create_data_records: :environment do
    # Tags
    tag_1 = Tag.create(name: "waterfall")
    tag_2 = Tag.create(name: "montreal")
    tag_3 = Tag.create(name: "travel")
    tag_4 = Tag.create(name: "quebec")
    tag_5 = Tag.create(name: "sport")

    # Ads
    ad_1 = Ad.create(name: "Montreal Dorwin Falls", url: "http://igotchamedia.com/image.png")
    ad_2 = Ad.create(name: "Quebec City", url: "http://igotchamedia.com/video.mp4")
    ad_3 = Ad.create(name: "NHL Hightlight", url: "https://www.youtube.com/watch?v=lwCXLtqjsy8")

    # Playlists

    playlist_1 = Playlist.create(name: "Travel")

    # Associate ads with tags

    ## ad_1
    TaggedResource.create(tag_id: tag_1.id, taggable_resource_id: ad_1.id, taggable_resource_type: "Ad")
    TaggedResource.create(tag_id: tag_2.id, taggable_resource_id: ad_1.id, taggable_resource_type: "Ad")
    TaggedResource.create(tag_id: tag_3.id, taggable_resource_id: ad_1.id, taggable_resource_type: "Ad")
    ## ad_2
    TaggedResource.create(tag_id: tag_4.id, taggable_resource_id: ad_2.id, taggable_resource_type: "Ad")
    TaggedResource.create(tag_id: tag_3.id, taggable_resource_id: ad_2.id, taggable_resource_type: "Ad")
    ## ad_3
    TaggedResource.create(tag_id: tag_5.id, taggable_resource_id: ad_3.id, taggable_resource_type: "Ad")


    # Associate playlists with tags and ads

    AdDiffusionThroughPlaylist.create(ad_id: ad_3.id, playlist_id: playlist_1.id)

    playlist_1.deploy_tag_to_playlist(tag_3)

  end

  task destroy_all_data: :environment do
    Tag.destroy_all ; Ad.destroy_all ; Playlist.destroy_all ; TaggedResource.destroy_all ; AdDiffusionThroughPlaylist.destroy_all
  end



end