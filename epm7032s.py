#!/usr/bin/python

#
# This script generates a HTML documentation
# for the bitstream of an Altera EPM7032S CPLD.
#

import sys
from common import *

LABCount = 2
# Number of PIA-to-LAB muxes per LAB signal
PIAtoLABmuxCount = 2
IOCount = 32
bitCount = 15033


page = """<html>
<head>
<link rel="stylesheet" type="text/css" href="common.css"/>
</head>
<body>
<h1>Altera EPM7032S CPLD bitstream format</h1>

On this page an attempt is made to document the bitstream format necessary to program the above programmable logic device.
The presented information is obtained through reverse-engineering,
which -sadly- is necessary since the vendor does not provide specification documents,
which would be required for implementation of third-party software.
At some point, hopefully, the information presented here
will be sufficient to allow implementation of an Open Source bitstream writer for this device in the context of <a href="https://symbiflow.github.io/">SymbiFlow</a>.
<br/><br/>
This is an automatically generated page.
The corresponding generator can be found <a href="https://github.com/programmable-logic-tools/altera-max7000-db">here</a>.
The raw bitstream might have to be extracted from an Altera Quartus POF file first.
<a href="https://github.com/programmable-logic-tools/libalterapof/tree/master/doc">libalterpof</a> may help with that.
<br/><br/>
Keep in mind that as this is a third-party specification.
It might never be accurate or complete.
When you flash an incorrect bitstream into a programmable logic device, there is a good chance that you permanently break your device.
Use the information on this page at your own risk.
<br/><br/>
The bitstream for the <a href="https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/ds/archives/m7000.pdf">EPM7032S</a> consists of """+str(bitCount)+""" bits in total.<br/>
"""

#
# Product terms
#
bitOffset = 0
(htm, tr, bitCount) = generateHTMLForProductTerms(
                        LABCount = LABCount,
                        bitOffset = bitOffset
                        )
page += htm
table = tr
bitOffset += bitCount

#
# Macrocell configuration
#
(htm, tr, bitCount) = generateHTMLForMacrocellConfiguration(
            LABCount = LABCount,
            bitOffset = bitOffset
            )
page += htm
table += tr
bitOffset += bitCount

#
# PIA-to-LAB signal mux configuration
#
(htm, tr, bitCount) = generateHTMLForPIAtoLABrouting(
            LABCount = LABCount,
            PIAtoLABmuxCount = PIAtoLABmuxCount,
            bitOffset = bitOffset
            )
page += htm
table += tr
bitOffset += bitCount

#
# I/O configuration
#
(htm, tr, bitCount) = generateHTMLForIOConfiguration(
            IOCount = IOCount,
            bitOffset = bitOffset
            )
page += htm
table += tr
bitOffset += bitCount

#
# Extra bits of unknown function
#
(htm, tr, bitCount) = generateHTMLForExtraBits(17, bitOffset)
#page += htm
table += tr
bitOffset += bitCount

#
# Usercode
#
(htm, tr, bitCount) = generateHTMLForUsercode(
            bitOffset = bitOffset
            )
page += htm
table += tr
bitOffset += bitCount


page += """
<h2>Unidentified functions</h2>
The yet unidentified bits of the bitstream are expected to configure:
<ul>
<li>Product selection for sum-of-products term</li>
<li>XOR second input signal selection</li>
<li>Cascading from previous/to next macrocell</li>
<li>Flipflop vs. latch selection/mux</li>
<li>FF clock signal selection</li>
<li>FF enable signal selection</li>
<li>Configuration of feedback from macrocell to PIA</li>
<li>I/O Output Enable (OE) signal selection</li>
<li>I/O type selection: push-pull vs. open collector</li>
<li>I/O slew rate control: slow vs. fast</li>
<li>Usercode</li>
<li>JTAG enable/disable</li>
</ul>
"""

page += """<h2>Bit table</h2>
<table>
"""+table+"""
</table>
"""

page += "</body>\n</html>"

# Write to file
f = open("epm7032s.html", "w")
f.write(page)
f.close()
