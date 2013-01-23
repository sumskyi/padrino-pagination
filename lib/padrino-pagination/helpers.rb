module Padrino
  module Helpers
    module Pagination

      def self.registered app
        app.helpers self
      end

      class OptsProcessor
        def initialize items_count, per_page, current_page
          @items_count, @per_page, @current_page = items_count, per_page, current_page

          @total_pages = (@items_count/@per_page.to_f).ceil
        end

        def result
          {
            :per_page => @per_page,
            :total_pages => @total_pages,
            :total_items => @items_count,
            :current_page => @current_page,

            :previous_page => (@current_page <= 1            ? nil : @current_page - 1),
            :next_page     => (@current_page >= @total_pages ? nil : @current_page + 1)
          }
        end
      end

      # Usage:
      #
      # <%= paginate :posts, :index, Post.count, :template => 'classic', :per_page => 50, :page => params[:page] %>
      #
      # :page is important!
      def paginate(controller, action, total, opts={})
        template = opts.delete(:template) || 'punbb' # 'extended', 'classic', 'brutal', 'digg'

        per_page = opts.delete(:per_page) || 20
        current_page = (opts.delete(:page) || 1 ).to_i

        partial_path = File.expand_path("../../../views",__FILE__)
        partial_path = File.join(partial_path, "#{template}.haml")

        opts[:controller] = controller
        opts[:action] = action

        opts.merge! OptsProcessor.new(total, per_page, current_page).result

        opts[:first_page]     = current_page == 1 ?                  nil : 1
        opts[:last_page]      = current_page >= opts[:total_pages] ? nil : opts[:total_pages]

        # for "classic"
        opts[:current_first_item] = [((current_page-1) * opts[:per_page]) + 1, total].min
        opts[:current_last_item]  = [opts[:current_first_item] + opts[:per_page] - 1, total].min

        Tilt::HamlTemplate.new(partial_path).render(self, opts)
      end

    end
  end
end
