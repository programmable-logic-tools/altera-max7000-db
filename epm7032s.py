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
</head>
<body>
<h1>Altera EPM7032S CPLD bitstream format</h1>
This is an automatically generated page.
The corresponding generator can be found <a href="https://github.com/programmable-logic-tools/altera-max7000-db">here</a>.
The raw bitstream might have to be extracted from an Altera Quartus POF file first.
<a href="https://github.com/programmable-logic-tools/libalterapof/tree/master/doc">libalterpof</a> may help with that.
<br/><br/>
The bitstream for the <a href="https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/ds/archives/m7000.pdf">EPM7032S</a> consists of """+str(bitCount)+""" bits in total.<br/>
<h2>Product terms</h2>
"""

html += generateTablesForProductTerms(
            LABCount = LABCount
            )

html += """
<h2>Remaining bits</h2>
The remaining bits of the bitstream are expected to configure:
<ul>
<li>PIA-to-LAB routing</li>
<li>Product selection for sum-of-products term</li>
<li>XOR second input signal selection</li>
<li>Cascading from previous/to next macrocell</li>
<li>Flipflop vs. latch selection/mux</li>
<li>FF clock signal selection</li>
<li>FF enable signal selection</li> 
<li>I/O Output Enable (OE) signal selection</li>
<li>I/O type selection: push-pull vs. open collector</li>
<li>I/O slew rate control: slow vs. fast</li>
<li>JTAG enable/disable</li>
</ul>
"""

html += "</body>\n</html>"

# Write to file
f = open("epm7032s.html", "w")
f.write(html)
f.close()
