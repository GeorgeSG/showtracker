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

      dataset = dataset.where ilike('shows.name', name)     unless name.nil?
      dataset = dataset.where ilike('shows.status', status) unless status.nil?

      dataset = join_actors(dataset, actor)     unless actor.nil?
      dataset = join_genres(dataset, genre)     unless genre.nil?
      dataset = join_networks(dataset, network) unless network.nil?

      dataset.select_all(:shows).distinct
    end

    def join_actors(dataset, actor_id)
      dataset = dataset
        .join(:actors_shows, actors_shows__show_id: :shows__id)
        .join(:actors,       actors__id: :actors_shows__actor_id)

      dataset.where(actors__id: actor_id)
    end

    def join_genres(dataset, genre_id)
      dataset = dataset
        .join(:shows_genres, shows_genres__show_id: :shows__id)
        .join(:genres,       genres__id: :shows_genres__genre_id)

      dataset.where(genres__id: genre_id)
    end

    def join_networks(dataset, network_id)
      dataset = dataset.join(:networks, networks__id: :shows__network_id)
      dataset.where(networks__id: network_id)
    end

    def select_all_shows(dataset)
      dataset.select_all(:shows).distinct
    end

    def select_cards_for_show(name)
      items_per_page = 12
      criteria = search_for(name).order_by(Sequel.desc(:rating_count))
      initialize_paging_properties(items_per_page, criteria.count)

      @shows = criteria.limit(items_per_page, @offset).all
    end

    def select_cards_for_object(object)
      object_name = object.class.to_s.downcase
      items_per_page = 12

      dataset = send "join_#{object_name}s", Show, object.id
      dataset = dataset.order_by(Sequel.desc(:rating_count))
      dataset = select_all_shows(dataset)

      initialize_paging_properties(items_per_page, dataset.count)

      @shows = dataset.limit(items_per_page, @offset).all
    end
  end
end
