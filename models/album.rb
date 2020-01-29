require('pg')
require_relative('../db/sql_runner')

class Album

  attr_accessor :genre, :name
  attr_reader :id, :artist_id
  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @genre = options["genre"]
    @artist_id = options["artist_id"].to_i()
  end

  def save()
    sql = "INSERT INTO albums
    (name, genre, artist_id)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@name, @genre, @artist_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i()
  end

  def artist()
    sql = "SELECT * FROM artists
    WHERE
    id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_data = result[0]
    artist = Artist.new(artist_data)
    return artist
  end

  def update()
    sql = "UPDATE albums
    SET
    (name, genre, artist_id) =
    ($1, $2, $3)
    WHERE
    id = $4"
    values = [@name, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums
    WHERE
    id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map{|album| Album.new(album)}
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end
end
