module Seeds
  class Items
    def self.create()
      # YAMLファイルの読み込み
      sweets_data = YAML.load_file(Rails.root.join("db", "seeds", "sweets.yml"))

      # 各スイーツデータに対するループ処理
      sweets_data.each do |sweet|
        item = Item.create!(
          name: sweet["name"],
          introduction: sweet["introduction"],
          genre_id: sweet["genre"],
          non_taxed_price: rand(10..100) * 10,
          is_active: true
        )

        item.image.attach(
          io: File.open(Rails.root.join("app/assets/images/sweets/#{sweet["key"]}.png")),
          filename: "#{sweet["key"]}.png"
        )
        puts "[Seeds] Created Item of #{sweet["name"]}"
      end
    end
  end
end
