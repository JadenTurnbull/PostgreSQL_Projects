import matplotlib.pyplot as plt
from matplotlib.patches import Patch

figure = plt.figure()
axes = figure.add_subplot()

axes.bar(
    range(6),
    [150, 90, 75, 55, 123, 190],
    tick_label=["Apple", "Burberry", "Google", "Zara", "Microsoft", "Superdry"],
    color=["#5c44fd", "#ff5566", "#5c44fd", "#ff5566", "#5c44fd", "#ff5566"]
)

handles = [
    Patch(facecolor="#5c44fd", label="Tech"),
    Patch(facecolor="#ff5566", label="Clothing")
]

plt.legend(handles=handles)

plt.xticks(rotation=30, ha="right")
plt.show()