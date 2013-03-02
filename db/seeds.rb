Category.delete_all

Category.create(:name => "Rukavice")

topanky = Category.create(:name => "Topanky")
Category.create(:name => "Tenisky", :parent_id => topanky.id)
Category.create(:name => "Papuce", :parent_id => topanky.id)

oblecenie = Category.create(:name => "Oblecenie")
Category.create(:name => "Nohavice", :parent_id => oblecenie.id)
tricka = Category.create(:name => "Tricka", :parent_id => oblecenie.id)

Category.create(:name => "Tricka s kratkym rukavom", :parent_id => tricka.id)
Category.create(:name => "Tricka bez rukavov", :parent_id => tricka.id)


