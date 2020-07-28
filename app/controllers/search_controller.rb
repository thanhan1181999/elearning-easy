class SearchController < ApplicationController
  def index
    @words = Word.ransack(params[:query]).result(distinct: true)
  end

end
