import json

with open('rows.json') as json_file:    
    data = json.load(json_file)['data']

transformed = [[e[8],e[9],e[14],e[15],e[16],e[21][1],e[21][2]] for e in data]
import csv
with open('heatmap.csv', 'wb') as csvfile:
    writer = csv.writer(csvfile)
    for row in transformed:
        writer.writerow(row)
# Afterwards, run split -l 800000 heatmap.csv because CartoDB throws an error on
# uploaded files that are too big
