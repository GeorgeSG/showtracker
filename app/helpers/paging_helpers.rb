module ShowTracker
  # Paging Helpers - helpers for pagination views
  module PagingHelpers
    def initialize_paging_properties(items_per_page = 10, results_count)
      calculate_current_page
      @total_pages = results_count / items_per_page + 1
      @offset = items_per_page * (@page - 1)
      calculate_start_and_end
    end

    private

    def calculate_current_page
      @page = params[:page].to_i
      @page = 1 if @page < 1
    end

    def calculate_start_and_end
      if @total_pages < 5
        @start_page, @end_page = 1, @total_pages
      elsif @page <= 2
        @start_page, @end_page = 1, 5
      elsif @page >= (@total_pages - 2)
        @start_page, @end_page = @total_pages - 4, @total_pages
      else
        @start_page, @end_page = @page - 2, @page + 2
      end
    end
  end
end
