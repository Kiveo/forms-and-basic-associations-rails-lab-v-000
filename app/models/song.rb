class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  # want to get/set artist_name
  def artist_name=(name) #set song.artist whenever a value is passed to artist_name
    self.artist = Artist.find_or_create_by(name: name)
  end
  def artist_name #if song has an artist, get it's name. Otherwise, return nil.
    self.artist ? self.artist.name : nil
  end

  #want to be able to method call genre_name
  def genre_name=(name) #set a Genre whenever a name/value is passed to genre_name
    self.genre = Genre.find_or_create_by(name: name)
  end
  def genre_name #get genre's name, if song has a genre
    self.genre ? self.genre.name : nil
  end

  # setter 1. sets notes, 2. adds to existing, 3. ignores blank notes
  def note_contents=(contents) #working with a collection, not a singular value. Add value to .notes
    contents.each do |content|
      self.notes.build(content: content) if content != ""
    end
  end

  def note_contents   # getter returns content of all notes as an array
    self.notes.collect{|note| note.content}
  end

end
