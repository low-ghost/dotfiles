from time import sleep
import sys

for i in range(1, 10):
    sleep(0.5)
    sys.stdout.write('i = {}'.format(i))
