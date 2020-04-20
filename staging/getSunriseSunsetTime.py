#### script to download sunrise and sunset time each day in Washington Square Park, NYC
import sys
import json
import urllib
from urllib.request import urlopen
import datetime
import pandas as pd
from pandas.io.json import json_normalize

sys.path.append('../')
from envir import config

####

date_range = pd.date_range(start="2016/01/01", end="2020/04/15").astype(str)
# from google maps
# https://www.google.com/maps/place/Washington+Square+Park/@40.730959,-73.9987294
lat = '40.730959'
long = '-73.9987294'

dailySunDoc = pd.DataFrame()

for day in date_range:
    sundoc = urllib.request.urlopen('https://api.sunrise-sunset.org/json?lat='+
                                    lat+'&lng='+long+'&date='+day)
    print('https://api.sunrise-sunset.org/json?lat='+
                                    lat+'&lng='+long+'&date='+day)
    sundoc = json.loads(sundoc.read())
    tempSunDoc = json_normalize(sundoc['results'])
    tempSunDoc['date'] = day
    dailySunDoc = dailySunDoc.append(tempSunDoc, ignore_index=True)
    
dailySunDoc.to_csv(config.dataFol+'sunrise/sunrisesunsetutc.csv', index=False)