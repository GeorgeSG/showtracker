class SeriesCollectionWorker
  include Sidekiq::Worker
  require 'open-uri'

  sidekiq_options queue: :shows

  attr_reader :id

  def perform(show_id)
    @id = show_id

    show = serialize_show

    if show
      download_images(show)
      start_episode_workers
    end
  end

  private

  def xml
    api_key = Settings.tvdb.api_key
    url     = Settings.tvdb.series_url % { api_key: api_key, series_id: id }
    @xml  ||= Nokogiri::XML(open(url))
  end

  def series
    xml.xpath("//Data/Series")
  end

  def serialize_show
    ShowSerializer.new(series).serialize
  end

  def download_images(show)
    ImageCollectionWorker.perform_async(:poster, show.poster) unless show.poster.blank?
    ImageCollectionWorker.perform_async(:banner, show.banner) unless show.banner.blank?
    ImageCollectionWorker.perform_async(:fanart, show.fanart) unless show.fanart.blank?
  end

  def start_episode_workers
    EpisodesCollectionWorker.perform_async(xml, id)
  end
end
