import os
from collections import defaultdict
import matplotlib.pyplot as plt
import seaborn as sns

# Replace with the root directory containing the 78 folders
root_directory = "/path/to/your/folders"

def read_config_keys(file_path):
    """Reads keys from a config.ini file."""
    keys = set()
    with open(file_path, 'r') as f:
        for line in f:
            # Ignore comments and empty lines
            line = line.strip()
            if line and not line.startswith("#"):
                if "=" in line:
                    key = line.split("=", 1)[0].strip()
                    keys.add(key)
    return keys

def jaccard_similarity(set1, set2):
    """Calculates Jaccard similarity between two sets."""
    intersection = len(set1 & set2)
    union = len(set1 | set2)
    return intersection / union if union != 0 else 0

# Threshold for partial similarity (e.g., 70%)
similarity_threshold = 0.7

# Store folder to keys mapping
folder_keys = {}

# Traverse folders and read config.ini
for folder in os.listdir(root_directory):
    folder_path = os.path.join(root_directory, folder)
    config_path = os.path.join(folder_path, "config.ini")
    if os.path.isdir(folder_path) and os.path.isfile(config_path):
        folder_keys[folder] = read_config_keys(config_path)

# Group folders by key similarity
groups = []
processed = set()

for folder1, keys1 in folder_keys.items():
    if folder1 not in processed:
        group = [folder1]
        for folder2, keys2 in folder_keys.items():
            if folder1 != folder2 and folder2 not in processed:
                similarity = jaccard_similarity(keys1, keys2)
                if similarity >= similarity_threshold:
                    group.append(folder2)
        groups.append(group)
        processed.update(group)

# Save the groups to a file
output_file = "output.txt"
with open(output_file, "w") as f:
    f.write("Grouped folders based on partial key similarity:\n")
    for i, group in enumerate(groups, 1):
        f.write(f"\nGroup {i}:\n")
        f.write(f"Folders: {group}\n")
print(f"Results saved to {output_file}")

# Visualize similarity scores
folders = list(folder_keys.keys())
num_folders = len(folders)
similarity_matrix = [[0] * num_folders for _ in range(num_folders)]

for i, folder1 in enumerate(folders):
    for j, folder2 in enumerate(folders):
        similarity_matrix[i][j] = jaccard_similarity(folder_keys[folder1], folder_keys[folder2])

# Create a heatmap
plt.figure(figsize=(12, 10))
sns.heatmap(
    similarity_matrix,
    xticklabels=folders,
    yticklabels=folders,
    cmap="Blues",
    annot=True,
    fmt=".2f",
    cbar_kws={'label': 'Jaccard Similarity'}
)
plt.title("Pairwise Similarity Heatmap")
plt.xlabel("Folders")
plt.ylabel("Folders")
plt.xticks(rotation=45, ha="right", fontsize=8)
plt.yticks(fontsize=8)
plt.tight_layout()

# Save the heatmap
heatmap_file = "similarity_heatmap.png"
plt.savefig(heatmap_file)
plt.show()
print(f"Heatmap saved to {heatmap_file}")
