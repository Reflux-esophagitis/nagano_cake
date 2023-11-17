module Seeds
  DEFAULT_GENRES = [
    "ケーキ",
    "プリン",
    "焼き菓子",
    "キャンディ"
  ]

  class Genres
    def self.create()
      DEFAULT_GENRES.each do |genre|
        Genre.create!(
          name: genre
        )
        puts "[Seeds] Created Genre of \"#{genre}\""
      end
    end
  end
end
