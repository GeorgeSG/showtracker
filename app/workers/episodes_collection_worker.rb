class EpisodesCollectionWorker
  include Sidekiq::Worker

  sidekiq_options queue: :episodes

  attr_reader :xml, :show_id

  def perform(xml, show_id)
    @xml = Nokogiri::XML(xml)
    @show_id = show_id

    serialize_episodes
  end

  private

  def episodes
    @episodes ||= xml.xpath("//Data/Episode")
  end

  def serialize_episodes
    episodes.each { |e| EpisodeSerializer.new(e, show_id).serialize }
  end
end
