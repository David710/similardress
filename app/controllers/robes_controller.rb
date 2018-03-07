class RobesController < ApplicationController
  def index

    data = get_all_vector_features[:data]
    index_dress = get_all_vector_features[:index_dress]
    @robe_chosen = Robe.find(rand(1..100)) # attention
    array_nearest_neighbours = @robe_chosen.nearest_neighbours(data, 9)

    index_neighbours = []
    array_nearest_neighbours.each do |ind|
      index_neighbours << index_dress[ind]
    end

    @robe_neighbours = Robe.find(index_neighbours)

    render "index"
  end

  def show

    data = get_all_vector_features[:data]
    index_dress = get_all_vector_features[:index_dress]

    @robe_chosen = Robe.find(params[:id]) # attention
    array_nearest_neighbours = @robe_chosen.nearest_neighbours(data, 9)

    index_neighbours = []
    array_nearest_neighbours.each do |ind|
      index_neighbours << index_dress[ind]
    end

    @robe_neighbours = Robe.find(index_neighbours)

    render "index"

  end

  def get_all_vector_features

    # fill a data array with all feature vectors from the Robe database
    data = []
    index_dress = []
    Robe.find_each do |dress|
      puts "xxxxxxxxxxxxxxxxxx"
      puts data
      puts "xxxxxxxxxxxxxxxxxx"
      data << JSON.parse(dress.feature_vector)
      index_dress << dress.id
    end

    return { data: data, index_dress: index_dress }
  end

end
