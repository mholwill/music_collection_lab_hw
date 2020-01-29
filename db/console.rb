require('pry')
require_relative('../models/artist')
require_relative('../models/album')


artist1 = Artist.new({
  "name" => "Sam"
  })
artist1.save()

album1 = Album.new({
  "name" => "album_name",
  "genre" => "metal",
  "artist_id" => artist1.id
  })
album1.save()

binding.pry
nil
