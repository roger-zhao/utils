import numpy as np
import matplotlib.pyplot as plt

import csv

csv_file = file('test.csv', 'rb')
reader = csv.reader(csv_file)
ch = []
pwm = []

for line_str in reader:
    ch.append(line_str[0])
    pwm.append(line_str[1]+line_str[2])

for item, value in ch, pwm:
    print item + ":" + value
csv_file.close()
plt.figure(1)
plt.plot(ch, pwm)
plt.show()


