class Song

  @@count = 0
  @@artists = []
  @@all_artists = []
  @@genres = []

  @@artist_count = {}
  @@genre_count = {}

  attr_accessor :name, :artist, :genre

  def initialize(name, artist, genre)
    @name = name
    @artist = artist
    @genre = genre

    @@count += 1
    @@genres.push(@genre)
    @@artists.push(@artist)

  end

  def self.count
    @@count
  end

  def self.artists
    @@artists.uniq
  end

  def self.genres
    @@genres.uniq
  end

  def self.artist_count
  @@artists.each do | artist |
    if artist_count.key?(artist)
      artist_count["artist"] +=1
    else
      artist_count["artist"] = 1
    end
  end # end of artists.each
  
  @@artist_count
  end

  def self.genre_count


  end

end
