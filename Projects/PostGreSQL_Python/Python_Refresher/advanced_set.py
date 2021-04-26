# -- Difference between two sets --

friends = {"Bob", "Rolf", "Anne"}
abroad = {"Bob", "Anne"}

local = friends.difference(abroad)
print(local)

print(abroad.difference(friends))  # This returns an empty set

# -- Union of two sets --

local = {"Rolf"}
abroad = {"Bob", "Anne"}

friends = local.union(abroad)
print(friends)

# -- Intersection of two sets --

art = {"Bob", "Jen", "Rolf", "Charlie"}
science = {"Bob", "Jen", "Adam", "Anne"}

# Given these two sets of students, we can calculate those who do both art and science by using `.intersection`

both = art.intersection(science)
print(both)