require 'pry'

class Artist
  attr_accessor :name, :songs
  extend Concerns::Findable

  @@all = []
#____________________________________________________

  def initialize(name)
    @songs = []
    @name = name
  end
#____________________________________________________

  def self.create(artist)
    artist = self.new(artist).save
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
    if song.artist == nil
      song.artist=(self)
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

  def genres
  list_of_genres = self.songs.map {|song| song.genre}
  list_of_genres.uniq
  end
#____________________________________________________

end
