import matplotlib.pyplot as plt

plt.figure()

plt.xlabel("Categories")
plt.ylabel("Amounts")
plt.title("Categories vs Amounts")

lines = plt.plot(["Men", "Women", "Children"], [3, 5, 9])
plt.show()