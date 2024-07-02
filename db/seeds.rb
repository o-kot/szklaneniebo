# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Author.create(
  name: 'Alicja Zapolska',
  about: "Fascynacja witrażami była we mnie od zawsze.\nObraz, który się zmienia. Gra światła do słonecznej muzyki.\nKiedyś byłam przekonana, że witraże to hobby dla nielicznych.\nI tak jest - wymaga cierpliwości, pokory, akceptacji, niespieszności.\nSzkło - kruche i twarde, zimne i ciepłe, delikatne i ostre...\nZauroczyło mnie i wypełniło wolne chwile.\nWitrażowe hobby trwa już kilka lat, pracuję w technice Tiffaniego.\nMoje prace goszczą w wielu domach, zarówno w Polsce jak i za granicą.\nKONTAKT - alicja-631@wp.pl\nDziękuję za odwiedzenie mej strony..."
)