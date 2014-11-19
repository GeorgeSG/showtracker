class TriggerCollectionWorker
  include Sidekiq::Worker

  def perform(count)
    to_download = series_ids
    to_download = series_ids.first(count) if count

    to_download.each { |show_id| SeriesCollectionWorker.perform_async(show_id) }
  end

  private

  def xml
    if @xml.nil?
      f = File.open('/home/georgesg/Desktop/series_ids')
      @xml = Nokogiri::XML(f)
      f.close
    end

    @xml
  end

  def series_ids
    @series_ids ||= xml.xpath("//id").map(&:text)
  end
end
