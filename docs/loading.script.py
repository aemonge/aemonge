#!/usr/bin/env python3
from time import sleep

loading_dots = '⋅'
for _ in range(5):
  print(loading_dots + '|', end='\r')
  sleep(0.2)
  print(loading_dots + '/', end='\r')
  sleep(0.2)
  print(loading_dots + '-', end='\r')
  sleep(0.2)
  print(loading_dots + '\\', end='\r')
  sleep(0.5)
  loading_dots += '⋅'
print()
