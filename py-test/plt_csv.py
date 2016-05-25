import numpy as np
import matplotlib.pyplot as plt

import csv
import string as str

csv_file = file('test.csv', 'rb')
reader = csv.reader(csv_file)
pwm = [[] for i in range(3)]

for line_str in reader:
    pwm[(str.atoi(line_str[0]))].append(str.atof(line_str[1])+str.atof(line_str[2]))

for ii in range(3):
    print ii
    print pwm[ii]
csv_file.close()
plt.figure(1)
# plt.show()


