class SearchController < ApplicationController
  def index
    if params[:query].nil?
      @words = nil
    else
      @words = Word.search(params[:query]).records
    end
  end

end
