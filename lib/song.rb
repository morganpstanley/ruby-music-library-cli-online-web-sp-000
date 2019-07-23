class Song
  attr_accessor :name, :genre
  attr_reader :artist

  @@all = []
#____________________________________________________

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if genre
      self.genre=(genre)
    end
    if artist
      self.artist=(artist)
    end
  end
#____________________________________________________

  def self.all
    @@all
  end
#____________________________________________________

  # def genre=(genre)
  #   @genre = genre
  #   binding.pry
  # end

  def genre=(genre)
    if genre.is_a?(String)
      genre = Genre.find_or_create_by_name(genre)
    end
    @genre = genre
    genre.add_song(self)
    @genre = genre
  end


#____________________________________________________

#artist=
# => assigns an artist to the song (song belongs to artist)
# => invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)

def artist=(artist)
  if artist.is_a?(String)
    artist = Artist.find_or_create_by_name(artist)
  end
  @artist = artist
  artist.add_song(self)
  @artist = artist
end
#____________________________________________________

  def self.destroy_all
    @@all.clear
  end
#____________________________________________________

  def save
    @@all << self
  end
#____________________________________________________

  def self.create(song)
    song = Song.new(song)
    song.save
    song
  end
#____________________________________________________

  def self.find_by_name(name)
    @@all.detect{|song| song.name == name}
  end
#____________________________________________________

  def self.find_or_create_by_name(song)
    if self.find_by_name(song) == nil
      self.create(song)
    else
      self.find_by_name(song)
    end
  end
#____________________________________________________

  def self.new_from_filename(file)
    artist, song, genre = file.chomp(".mp3").split(" - ")
    if self.find_by_name(song) == nil
      song = self.new(song, artist, genre)
    end
  end
#____________________________________________________

  def self.create_from_filename(file)
    self.new_from_filename(file).save
  end
#____________________________________________________
end
