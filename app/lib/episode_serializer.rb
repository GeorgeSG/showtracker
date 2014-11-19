class EpisodeSerializer
  def initialize(episode_xml, show_id)
    @episode_xml, @show_id = episode_xml, show_id.to_s
  end

  def serialize
    ActiveRecord::Base.transaction do
      episode.api_id                  = @episode_xml.css("id").text
      episode.combined_episode_number = @episode_xml.css("Combined_episodenumber").text
      episode.combined_season         = @episode_xml.css("Combined_season").text
      episode.director                = @episode_xml.css("Director").text
      episode.name                    = @episode_xml.css("EpisodeName").text
      episode.episode_number          = @episode_xml.css("EpisodeNumber").text.to_i
      episode.first_aired             = @episode_xml.css("FirstAired").text
      episode.imdb_id                 = @episode_xml.css("IMDB_ID").text
      episode.language                = @episode_xml.css("Language").text
      episode.overview                = @episode_xml.css("Overview").text
      episode.rating                  = @episode_xml.css("Rating").text.to_f
      episode.rating_count            = @episode_xml.css("RatingCount").text.to_i
      episode.season_number           = @episode_xml.css("SeasonNumber").text.to_i
      episode.writer                  = @episode_xml.css("Writer").text
      episode.airs_before_episode     = @episode_xml.css("airsbefore_episode").text.to_i
      episode.airs_before_season      = @episode_xml.css("airsbefore_season").text.to_i
      episode.photo                   = @episode_xml.css("filename").text
      episode.last_updated            = @episode_xml.css("lastupdated").text
      episode.season_api_id           = @episode_xml.css("seasonid").text
      episode.series_api_id           = @episode_xml.css("seriesid").text
      episode.thumb_added             = @episode_xml.css("thumb_added").text
      episode.thumb_height            = @episode_xml.css("thumb_height").text.to_i
      episode.thumb_width             = @episode_xml.css("thumb_width").text.to_i

      episode.show = show

      episode.save!
    end

    episode
  end

  private

  def show
    @show ||= Show.where(api_id: @show_id).first
  end

  def episode
    api_id = @episode_xml.css("id").text

    @episode ||= Episode.where(api_id: api_id).first || Episode.new
  end
end