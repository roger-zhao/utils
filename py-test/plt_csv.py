import numpy as np
import matplotlib.pyplot as plt

import csv
import string

plt.figure(1)
csv_file = file('test.csv', 'rb')
reader = csv.reader(csv_file)
max_ch = 6
err_th = 1.5 # error if current > average*1.5
line_no = 0
ch_value_cnt = [0 for i in range(max_ch)]
ch_value_sum = [0 for i in range(max_ch)]
average = [0 for i in range(max_ch)]
pwm = [[] for i in range(max_ch)]

for line_string in reader:
    line_no += 1
    ch_num = string.atoi(line_string[0])
    high = string.atoi(line_string[1])
    low = string.atoi(line_string[2])
    peroid = high + low
    if (ch_num < max_ch):
        pwm[ch_num].append(peroid)
        if(peroid > average[ch_num]*1.5) and (average[ch_num] != 0):
            print "%d: ch-%d, h-%d, l-0x%x" % (line_no, ch_num, high, low)
        else:
            ch_value_cnt[ch_num] += 1
            ch_value_sum[ch_num] += peroid
            average[ch_num] = ch_value_sum[ch_num]/ch_value_cnt[ch_num]

        if(low > 500):
            print "%d: ch-%d, h-%d, l-0x%x" % (line_no, ch_num, high, low)
        if(high > 2000) and (high < 2500):
            print "%d: ch-%d, h-%d, l-0x%x" % (line_no, ch_num, high, low)

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


