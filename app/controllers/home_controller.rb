class HomeController < ApplicationController

  def index
    @randocommando = Deckbrew.new.get_random_commander
    render :index
  end
end
