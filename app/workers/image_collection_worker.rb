class ImageCollectionWorker
  require 'fileutils'
  require "open-uri"

  include Sidekiq::Worker

  sidekiq_options queue: :images

  attr_reader :type, :url

  def perform(type, url)
    return if url.blank?

    Settings.reload!

    @type, @url = type.to_sym, url

    create_folder
    download_image
  end

  private

  def folder
    subfolder = case type
      when :poster then 'posters'
      when :fanart then 'fanart/original'
      when :banner then url.split("/").first
    end

    "public/images/#{subfolder}/"
  end

  def create_folder
    puts "creating folder #{folder}"
    FileUtils.mkdir_p(folder) unless Dir.exists?(folder)
  end

  def api_url
    "#{Settings.tvdb.banners_url}#{url}"
  end

  def local_url
    "public/images/#{url}"
  end

  def download_image
    File.write(local_url, open(api_url).read, {mode: 'wb'})
  end
end
