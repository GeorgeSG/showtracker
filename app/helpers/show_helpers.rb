module ShowTracker
  module ShowHelpers
    def ilike(column, value)
      "LOWER(#{column.to_s}) LIKE '%#{value.downcase}%'"
    end

    def search_for(value, in_columns: ['name'])
      query = in_columns.map { |column| ilike(column, value) }.join(' OR ')
      Show.where query
    end

    def advanced_search_dataset(name, actor, genre, network, status)
      dataset = Show

      unless name.nil?
        dataset = dataset.where ilike('shows.name', name)
      end

      unless actor.nil?
        dataset = dataset
          .join(:actors_shows, actors_shows__show_id: :shows__id)
          .join(:actors,       actors__id: :actors_shows__actor_id)

        dataset = dataset.where(actors__id: actor) unless actor.nil?
      end

      unless genre.nil?
        dataset = dataset
          .join(:shows_genres, shows_genres__show_id: :shows__id)
          .join(:genres,       genres__id: :shows_genres__genre_id)

        dataset = dataset.where(genres__id: genre) unless genre.nil?
      end

      unless network.nil?
        dataset = dataset.join(:networks,     networks__id: :shows__network_id)
        dataset = dataset.where(networks__id: network) unless network.nil?
      end

      unless status.nil?
        dataset = dataset.where ilike('shows.status', status)
      end

      dataset.select_all(:shows).distinct
    end
  end
end
