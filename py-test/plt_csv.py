import numpy as np
import matplotlib.pyplot as plt

import csv
import string

plt.figure(1)
csv_file = file('test.csv', 'rb')
reader = csv.reader(csv_file)
max_ch = 9
pwm = [[] for i in range(max_ch)]

for line_string in reader:
    if (string.atoi(line_string[0]) < max_ch):
        pwm[(string.atoi(line_string[0]))].append(string.atof(line_string[1])+string.atof(line_string[2]))

plt.title("rcin log");
plt.xlabel("rcin points");
plt.ylabel("rcin values");
plt.grid(True);
for ii in range(max_ch - 1):
    x = [i for i in range(len(pwm[ii]))]
    # y = [(i+3) for i in range(len(pwm[ii]))]
    plt.plot(x, pwm[ii], label="ch"+str(ii))
    plt.legend()
    # plt.plot(x, y)
csv_file.close()
print "plot done"
plt.show()


