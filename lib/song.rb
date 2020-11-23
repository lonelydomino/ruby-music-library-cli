class Song
    attr_accessor :name
    attr_reader :artist, :genre
    
    @@all = []

def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist #use if artist is not nil to assign it
    self.artist = artist
    end
    if genre #use if genre is not nil to assign it
    self.genre = genre
    end
end

def artist=(artist)
    @artist = artist
    artist.add_song(self)
end
def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
        genre.songs << self
    end
end
def self.all
    @@all
end
def self.destroy_all
    self.all.clear
end
def save
    self.class.all << self
end
def self.create(name)
    song = Song.new(name)
    song.save
    song
end
def self.find_by_name(name)
    Song.all.detect {|song| song.name == name}
end
def self.find_or_create_by_name(name)
    if !find_by_name(name)
        create(name)
    else 
        return find_by_name(name)
    end
end
def self.new_from_filename(filename)
    file_array = filename.split(" - ")
    artist_name = file_array[0]
    song_name = file_array[1]
    genre_name = file_array[2].gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    Song.new(song_name, artist, genre)
end
def self.create_from_filename(filename)
    new_from_filename(filename).save
end
end