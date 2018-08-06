class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []
  def initialize(name)
    @name = name
    @songs = []
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
  def artists
    songs.collect{|a| a.artist}.uniq
  end
  def self.create(name)
    self.new(name).tap{|g| g.save}
  end
end
