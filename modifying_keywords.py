import ast
import csv

# ------------------------------------------------------------
# This script reads `keywords.csv` (Instagram Dataset).
# Each row has:
#   - column 0: photo_id
#   - column 1: a JSON-like string of a list of keyword objects,
#               e.g. "[{'id': 13, 'name': 'fun'},....." 
# Notes:
#   - We sort outputs to keep results clean.
#   - We use ast.literal_eval to safely parse the JSON-like strings.
# ------------------------------------------------------------


photo_id_tag_id_array = []  # list of (photo_id, tag_id) pairs
tag_id_name_array = []      # list of (tag_id, tag_name) rows   
tag_id_name_dict = {}       # map tag_id -> tag_name (avoids duplicates)   

# -----------------------------
# Read input keywords.csv
# -----------------------------

input_file = open("in/keywords.csv", encoding="utf-8")
csvreader = csv.reader(input_file)
header = next(csvreader)

for row in csvreader:
    # The first column is the photo identifier
    photo_id = row[0]
    # The second column is a JSON-like string with a list of dicts:
    # "[{'id': 13, 'name': 'fun'},....." 
    json = row[1]
    # Example:
    # jsonString = "[{'id': 931, 'name': 'jealousy'}, {'id': 6054, 'name': 'friendship'}]"
    # data = ast.literal_eval(jsonString)
    # print(data)           → print [{'id': 931, 'name': 'jealousy'}, {'id': 6054, 'name': 'friendship'}]
    # print(data[0])        → print {'id': 931, 'name': 'jealousy'}
    # print(data[0]['id'])  → print 931
    data = ast.literal_eval(json)
    for keyword in data:
        tag_id = keyword["id"]
        tag_name = keyword["name"]
        photo_id_tag_id_array.append((photo_id, tag_id))
        tag_id_name_dict[tag_id] = tag_name
input_file.close()


# ---------------------------------------
# Convert dictionary to array for output
# ---------------------------------------

for key, value in tag_id_name_dict.items():
    tag_id_name_array.append((key, value))

# ----------------
# Sort outputs 
# ----------------

photo_id_tag_id_array.sort()
tag_id_name_array.sort()

# -----------------------------
# Write to files
# -----------------------------
# Write out/photo_tags.csv
# -----------------------------

output_photo_tags = open("out/photo_tags.csv", "w", newline="", encoding="utf-8")
writer_photo_tags = csv.writer(output_photo_tags)
writer_photo_tags.writerow(("photo_id", "tag_id"))
for row in photo_id_tag_id_array:
    writer_photo_tags.writerow(row)
output_photo_tags.close()

# -----------------------------
# Write out/tags.csv
# -----------------------------

output_tags = open("out/tags.csv", "w", newline="", encoding="utf-8")
writer_tags = csv.writer(output_tags)
writer_tags.writerow(("id", "name"))
for row in tag_id_name_array:
    writer_tags.writerow(row)
output_tags.close()

# End of script
