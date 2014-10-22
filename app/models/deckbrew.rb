class Deckbrew
  def get_random_commander
    response = connection.get legendary_creature_url
    digested = JSON.parse response.body
    binding.pry
    chosen = digested.sample
    Summoner.new(chosen).random_image
  end


  def legendary_creature_url
    "/mtg/cards?format=commander&supertype=legendary&type=creature&page=20"
  end

  def connection
    @_connection ||= begin
      Faraday.new(:url => 'https://api.deckbrew.com') do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end
  end


  class Summoner
    attr_accessor :body

    def initialize(body)
      @body = body
    end

    def random_image
      body["editions"].sample["image_url"]
    end
  end
end
