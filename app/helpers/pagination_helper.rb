PadrinoDybil.helpers do
  def paginate(link, total, opts)
    opts = {
      :current_page => 1,
      :per_page     => 20,
      :template     => 'punbb' # 'extended', 'classic', 'brutal', 'digg'
    }.merge!(opts)

    opts[:link] = link

    opts[:total_pages]    = (total/opts[:per_page].to_f).ceil

    opts[:previous_page]  = opts[:current_page] <= 1 ?                  nil : opts[:current_page] - 1
    opts[:next_page]      = opts[:current_page] >= opts[:total_pages] ? nil : opts[:current_page] + 1

    opts[:first_page]     = opts[:current_page] == 1 ?                  nil : 1
    opts[:last_page]      = opts[:current_page] >= opts[:total_pages] ? nil : opts[:total_pages]

    # for "classic"
    opts[:current_first_item] = [((opts[:current_page]-1) * opts[:per_page]) + 1, total].min
    opts[:current_last_item]  = [opts[:current_first_item] + opts[:per_page] - 1, total].min
    opts[:total_items]        = total

    return partial("shared/pagination/#{opts[:template]}", :locals => opts) if opts[:total_pages] > 1
    ''
  end
end
