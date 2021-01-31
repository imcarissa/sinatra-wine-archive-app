# here I will seed data to work with the test associations

# Create 2 users

rachel = User.create(name: "Rachel", email: "RMGreen@bloomingdales.com", password: "password1234")
monica = User.create(name: "Monica", email: "ChefGellar@Javu.net", password: "7ways2clean")

# Create some wine entries

WineEntry.create(wine_type: "merlot", user_id: rachel.id)
        # make new seed file matching schema
        # where there is 'type'


# Use AR to pre-associate data

rachel.wine_entries.create(wine_type: "sauvignon blanc")
monica_entry = monica.wine_entries.build(wine_type: "merlot")
monica_entry.save