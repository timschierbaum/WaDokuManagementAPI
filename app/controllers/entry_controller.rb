class EntryController < ApplicationController
  def index
    if params[:query]
      response = RestClient.get "http://wadoku.eu:10010/api/v1/search", {params: params}
      @parsed = Yajl::Parser.parse(response)
    end

  end
end
