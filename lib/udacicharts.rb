require "open-uri"
require "nokogiri"

class BillboardCharts

  @limit = 100

  def initialize(chart_name='hot-100')
    url = 'http://www.billboard.com/charts/'+chart_name
    @scraped_data = Nokogiri::HTML(open(url))
  end

  def get_artists
    @scraped_data.css(".chart-row__artist").collect do |artist|
      artist.text.strip!
    end
  end

  def get_singles
    @scraped_data.css(".chart-row__song").collect do |song|
      song.text
    end
  end

  def get_list(limit=100)
    @limit=limit
    get_artists.zip(get_singles)
  end
end