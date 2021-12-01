import matplotlib.pyplot as plt

figure = plt.figure()
figure.subplots_adjust(wspace=0.5)
ax1 = figure.add_subplot(1, 2, 1)
ax2 = figure.add_subplot(1, 2, 2)

ax1.plot([1, 2, 3, 4], [3, 7, 11, 23])
ax2.plot([1, 2, 3, 4], [5, 9, 17, 25])

figure.savefig("graphs.png", bbox_inches="tight")