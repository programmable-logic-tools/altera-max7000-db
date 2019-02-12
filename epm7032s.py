#!/usr/bin/python

#
# This script generates a HTML documentation
# for the bitstream of an Altera EPM7032S CPLD.
#

from common import *

bitCount = 15033

LABCount = 2


html = """<html>
<head>
<link rel="stylesheet" type="text/css" href="common.css"/>
</head>s
<body>
<h1>Altera EPM7032S CPLD bitstream format</h1>
This is an automatically generated page. The corresponding generator can be found <a href="https://github.com/programmable-logic-tools/altera-max7000-db">here</a>.
<h2>Product terms</h2>
"""

html += generateTablesForProductTerms(
            LABCount = LABCount
            )

html += "</body>\n</html>"

# Write to file
f = open("epm7032s.html", "w")
f.write(html)
f.close()
