import matplotlib.pyplot as plt

# plt.figure()

# plt.xlabel("Categories")
# plt.ylabel("Amounts")
# plt.title("Categories vs Amounts")
#
# lines = plt.plot(["Men", "Women", "Children"], [3, 5, 9])

# plt.plot([1, 2, 3, 4], [3, 5, 9, 25])

# figure = plt.figure()
# axes = figure.add_subplot()
# axes.set_title("A test line graph")
# axes.set_xlabel("Numbers")
# axes.set_ylabel("Occurrences")
# axes.plot([1, 2, 3, 4], [3, 5, 9, 25])

# figure, (ax1, ax2) = plt.subplots(1, 2)
#
# ax1.plot([1, 2, 3, 4], [3, 5, 9, 25])
# ax2.plot([1, 2, 3, 4], [5, 7, 11, 17])

option_votes = [63, 28, 8]
option_names = [
    "Flask",
    "Django",
    "It depends"
]

figure = plt.figure()
axes = figure.add_subplot()

axes.pie(
    option_votes,
    labels=option_names,
    explode=[0.1, 0, 0],
    autopct="%1.1f%%"
)

plt.show()