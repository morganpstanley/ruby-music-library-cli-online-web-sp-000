class MusicImporter
  attr_reader :path, :files

#____________________________________________________
  def initialize(path)
    @path = path
    @files = Dir.entries(path).grep(/.*\.mp3/)
  end
#____________________________________________________
  def import
    @files.each {|file| Song.create_from_filename(file)}
  end
#____________________________________________________
end
