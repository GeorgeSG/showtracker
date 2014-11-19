class ShowSerializer
  attr_reader :series

  def initialize(series)
    @series = series
  end

  def serialize
    return false if series.css("SeriesName").text.blank?

    ActiveRecord::Base.transaction do
      show.name           = series.css("SeriesName").text
      show.api_id         = series.css("id").text
      show.airs_day       = series.css("Airs_DayOfWeek").text
      show.airs_time      = series.css("Airs_Time").text
      show.content_rating = series.css("ContentRating").text
      show.first_aired    = series.css("FirstAired").text
      show.imdb_id        = series.css("IMDB_ID").text
      show.language       = series.css("Language").text
      show.overview       = series.css("Overview").text
      show.rating         = series.css("Rating").text.to_f
      show.rating_count   = series.css("RatingCount").text.to_i
      show.running_time   = series.css("Runtime").text.to_i
      show.status         = series.css("Status").text
      show.added          = series.css("added").text
      show.added_by       = series.css("addedBy").text
      show.banner         = series.css("banner").text
      show.fanart         = series.css("fanart").text
      show.last_updated   = series.css("lastupdated").text
      show.poster         = series.css("poster").text

      find_or_create_network(series.css("Network").text)
      find_or_create_actors(series.css("Actors").text.split("|"))
      find_or_create_genres(series.css("Genre").text.split("|"))

      show.save!
    end

    show
  end

  private

  def show
    api_id = series.css("id").text
    @show ||= Show.where(api_id: api_id).first || Show.new
  end

  def find_or_create_network(network_name)
    unless network_name.blank?
      network = Network.find_or_create_by(name: network_name)
      show.network = network
    end
  end

  def find_or_create_actors(actors)
    actors.uniq.each do |name|
      next if name.blank?
      actor = Actor.where(name: name).first || Actor.create(name: name)

      show.actors << actor
    end
  end

  def find_or_create_genres(genres)
    genres.uniq.each do |name|
      next if name.blank?
      genre = Genre.where(name: name).first || Genre.create(name: name)

      show.genres << genre
    end
  end
end