require 'pry'

class MusicLibraryController
  attr_accessor :path, :files

#____________________________________________________

  def initialize(path = "./db/mp3s")
    @path = path
    @files = Dir.entries(path).grep(/.*\.mp3/)
    path = MusicImporter.new(path)
    path.import
  end
#____________________________________________________

  def call
    puts  "Welcome to your music library!"
    puts  "To list all of your songs, enter 'list songs'."
    puts  "To list all of the artists in your library, enter 'list artists'."
    puts  "To list all of the genres in your library, enter 'list genres'."
    puts  "To list all of the songs by a particular artist, enter 'list artist'."
    puts  "To list all of the songs of a particular genre, enter 'list genre'."
    puts  "To play a song, enter 'play song'."
    puts  "To quit, type 'exit'."
    puts  "What would you like to do?"

    input = ""

    until input == "exit" do
      input = gets.strip

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end
#____________________________________________________

  def list_songs
     Song.all.sort_by{|song| song.name}.each.with_index(1) {|song, index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end
#____________________________________________________

  def list_artists
    Artist.all.sort_by{|artist| artist.name}.each.with_index(1) {|artist, index| puts "#{index}. #{artist.name}"}
  end
#____________________________________________________

  def list_genres
    Genre.all.uniq{|genre| genre.name}.sort_by{|genre| genre.name}.each.with_index(1) {|genre, index| puts "#{index}. #{genre.name}"}
  end
#____________________________________________________

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.strip
    if artist_name
      Artist.all.each do |artist|
        if artist.name == artist_name
          artist.songs.sort_by{|song| song.name}.each.with_index(1) {|song, index| puts "#{index}. #{song.name} - #{song.genre.name}"}
        end
      end
    end
  end
#____________________________________________________

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.strip
    if genre_name
      Genre.all.each do |genre|
        if genre.name == genre_name
          genre.songs.sort_by{|song| song.name}.each.with_index(1) {|song, index| puts "#{index}. #{song.artist.name} - #{song.name}"}
        end
      end
    end
  end
#____________________________________________________

   def play_song
     puts "Which song number would you like to play?"
     input = gets.strip
     num = input.to_i
     if num.between?(1, 5)
       list_of_songs = Song.all.uniq{|artist| artist.name}.sort_by{|song| song.name}
       song_name = list_of_songs[num-1].name
       song_artist = list_of_songs[num-1].artist.name
       puts "Playing #{song_name} by #{song_artist}"
     end
   end
#____________________________________________________

end
