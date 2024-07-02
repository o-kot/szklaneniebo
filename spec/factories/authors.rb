FactoryBot.define do
  factory :author do
    name { "Alicja Zapolska" }
    about { "Fascynacja witrażami była we mnie od zawsze.\nObraz, który się zmienia. Gra światła do słonecznej muzyki.\nKiedyś byłam przekonana, że witraże to hobby dla nielicznych.\nI tak jest - wymaga cierpliwości, pokory, akceptacji, niespieszności.\nSzkło - kruche i twarde, zimne i ciepłe, delikatne i ostre...\nZauroczyło mnie i wypełniło wolne chwile.\nWitrażowe hobby trwa już kilka lat, pracuję w technice Tiffaniego.\nMoje prace goszczą w wielu domach, zarówno w Polsce jak i za granicą.\nKONTAKT - alicja-631@wp.pl\nDziękuję za odwiedzenie mej strony...\nAlicja Zapolska" }

    after(:create) do |author|
      file = Tempfile.new(['alice', '.png'])
      file.binmode
      file.write("fake image content")
      file.rewind

      author.photo.attach(io: file, filename: 'alice.png', content_type: 'image/png')
    end
  end
end
