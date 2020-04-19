### sample py script from 
### https://www1.ncdc.noaa.gov/pub/data/radar/bdp/scripts/
###
###################################################################

from xml.dom import minidom
from sys import stdin
from urllib import urlopen
from subprocess import call

def getText(nodelist):
    rc = []
    for node in nodelist:
        if node.nodeType == node.TEXT_NODE:
            rc.append(node.data)
    return ''.join(rc)


date = "2016/01/01"
site = "KGSP"
bucketURL = "http://noaa-nexrad-level2.s3.amazonaws.com"
dirListURL = bucketURL+ "/?prefix=" + date + "/" + site

print "listing files from %s" % dirListURL

#xmldoc = minidom.parse(stdin)
xmldoc = minidom.parse(urlopen(dirListURL))
itemlist = xmldoc.getElementsByTagName('Key')
print len(itemlist) , "keys found..."

# For this test, WCT is downloaded and unzipped directly in the working directory
# The output files are going in 'output'
# http://www.ncdc.noaa.gov/wct/install.php
for x in itemlist:
    file = getText(x.childNodes)
    print "Found %s " % file

