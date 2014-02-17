module ShowTracker
  module PagingHelpers
    def initialize_paging_properties(items_per_page = 10, results_count)
      @page = params[:page].to_i
      @page = 1 if @page < 1

      @total_pages = results_count / items_per_page + 1

      if @total_pages < 5
        @start_page = 1
        @end_page = @total_pages
      elsif @page <= 2
        @start_page = 1
        @end_page = 5
      elsif @page >= (@total_pages - 2)
        @start_page = @total_pages - 4
        @end_page = @total_pages
      else
        @start_page = @page - 2
        @end_page = @page + 2
      end

      @offset = items_per_page * (@page - 1)
    end
  end
end
