import numpy as np
import matplotlib.pyplot as plt

import csv

csv_file = file('test.csv', 'rb')
reader = csv.reader(csv_file)

for line_str in reader:
    print line_str[1] + line_str[2] + line_str[0]

csv_file.close()


