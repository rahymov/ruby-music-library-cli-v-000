class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre
  @@all = []
  def initialize(name, artist=nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  def self.all
    @@all
  end
  def self.destroy_all
    @@all.clear
  end
  def save
    @@all << self
  end

  def self.create(name, artist=nil, genre=nil)
    new(name,artist,genre).tap{|a| a.save}
  end

  def self.new_from_filename(filename)
    sep = filename.split(" - ")
    artist_name, song_name, genre_name = sep[0], sep[1], sep[2].gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{|s| s.save}
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

end
