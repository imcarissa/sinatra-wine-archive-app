# here I will seed data to work with the test associations

# Create 2 users

rachel = User.create(name: "Rachel", email: "RMGreen@bloomingdales.com", password: "password1234")
monica = User.create(name: "Monica", email: "ChefGellarM@Javu.net", password: "7ways2clean")

# Create some wine entries

WineEntry.create(user_id: rachel.id , vintage: 1999)


# Use AR to pre-associate data

rachel.wine_entries.create(vintage: 2005)
monica_entry = monica.wine_entries.build(vintage: 2010)
monica_entry.save