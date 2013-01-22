module Padrino
  module Helpers
    module Pagination

      def self.registered app
        app.helpers self
      end

      def paginate(controller, action, total, opts)
        opts = {
          :per_page     => 20,
          :template     => 'punbb' # 'extended', 'classic', 'brutal', 'digg'
        }.merge!(opts)

        current_page = (params[:page] || 1 ).to_i

        opts[:controller] = controller
        opts[:action] = action

        opts[:total_pages]    = (total/opts[:per_page].to_f).ceil

        opts[:previous_page]  = current_page <= 1 ?                  nil : current_page - 1
        opts[:next_page]      = current_page >= opts[:total_pages] ? nil : current_page + 1

        opts[:first_page]     = current_page == 1 ?                  nil : 1
        opts[:last_page]      = current_page >= opts[:total_pages] ? nil : opts[:total_pages]

        # for "classic"
        opts[:current_first_item] = [((current_page-1) * opts[:per_page]) + 1, total].min
        opts[:current_last_item]  = [opts[:current_first_item] + opts[:per_page] - 1, total].min
        opts[:total_items]        = total

        partial_path = File.expand_path("../../../views",__FILE__)
        partial_path = File.join(partial_path, "#{opts[:template]}.haml")

        opts.merge!( {
          :current_page => current_page
        })
        Tilt::HamlTemplate.new(partial_path).render(self, opts)
      end

    end
  end
end
