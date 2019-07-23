require 'pry'

class Genre
  attr_accessor :name, :songs
  extend Concerns::Findable

  @@all = []
#____________________________________________________

  def initialize(name)
    @songs = []
    @name = name
  end
#____________________________________________________

  def self.create(genre)
    genre = self.new(genre).save
  end
#____________________________________________________

  def self.all
    @@all
  end
#____________________________________________________

  def add_song(song)
    if self.songs.none?(song)
      @songs << song
    end
    if song.genre == nil
      song.genre=(self)
    end
  end
#____________________________________________________

  def self.destroy_all
    @@all.clear
  end
#____________________________________________________

  def save
    @@all << self
    self
  end
#____________________________________________________

  def artists
  list_of_artists = self.songs.map {|song| song.artist}
  list_of_artists.uniq
  end
#____________________________________________________

end
