class MusicLibraryController

def initialize(path = './db/mp3s')
    MusicImporter.new(path).import

end
def call
    response = 'go'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

    while response != 'exit'
        response = gets
        case response 
            when 'list songs'
                list_songs
            when 'list artists'
                list_artists
            when 'list genres'
                list_genres
            when 'play song'
                play_song
            when 'list artist'
                list_songs_by_artist
            when 'list genre'
                list_songs_by_genre
            when 'exit'
                break
        end
    end
end
def list_songs
    array = Song.all.sort{ |a, b| a.name <=> b.name }#sorts songs by name and saves in aray
    array.each_with_index do |song, i|#takes alphabetized song array and prints in numbered list
        puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
end
def list_artists
    array = Artist.all.sort{ |a, b| a.name <=> b.name}
    array.each_with_index do |artist, i|#takes alphabetized song array and prints in numbered list
        puts "#{i+1}. #{artist.name}"
    end
end
def list_genres
    array = Genre.all.sort{ |a, b| a.name <=> b.name}
    array.each_with_index do |genre, i|#takes alphabetized song array and prints in numbered list
        puts "#{i+1}. #{genre.name}"
    end
end
def list_songs_by_artist
    puts "Please enter the name of an artist:"
    choice = gets
    artist = Artist.find_by_name(choice)
    if artist
        array = artist.songs.sort{ |a, b| a.name <=> b.name }
        array.each_with_index do |song, i|
            puts "#{i+1}. #{song.name} - #{song.genre.name}"
        end
    end

end

def list_songs_by_genre
    puts "Please enter the name of a genre:"
    choice = gets
    genre = Genre.find_by_name(choice)
    if genre
        array = genre.songs.sort{ |a, b| a.name <=> b.name }
        array.each_with_index do |song, i|
            puts "#{i+1}. #{song.artist.name} - #{song.name}"
        end
    end
end

def play_song
    puts "Which song number would you like to play?"
    choice = gets.strip.to_i
    if choice > 0 && choice < Song.all.length
        song = Song.all[choice]
    end
    if song
        puts "Playing #{song.name} by #{song.artist.name}"
    end
end
end