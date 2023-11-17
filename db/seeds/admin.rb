module Seeds
  class Admins
    def self.create(email, password)
      Admin.create!(
        email: email,
        password: password,
      )
      puts "[Seeds] Created Admin user"
    end
  end
end
