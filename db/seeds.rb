# here I will seed data to work with the test associations

# Create 2 users

rachel = User.create(name: "Rachel Green", email: "RMGreen@bloomingdales.com", password: "password1234")
monica = User.create(name: "Monica Gellar", email: "ChefGellar@Javu.net", password: "7ways2clean")
phoebe = User.create(name: "Phoebe Buffay", email: "ReginaPhalange@CentralPerk.come", password: "smellycatsmellycat")

# Create some wine entries

WineEntry.create(wine_name: "Sancerre", wine_type: "white, sauvignon blanc", user_id: rachel.id, region: "Loire Valley", wine_notes: "Drank at office party. Must buy for birthday.")
        # make new seed file matching schema
        # where there is 'type'


# Use AR to pre-associate data

phoebe.wine_entries.create(wine_name: "champagne", wine_type: "sparkling red", wine_notes: "Got so drunk, I forgot where the keys to Mike's handcuffs where. 10/10")
# monica_entry = monica.wine_entries.
# monica_entry.save