#!/usr/bin/python

MacrocellsPerLAB = 16
ProductTermsPerMacrocell = 5
BitsPerProductTerm = 88
GlobalSignalsPerLAB = 36
BitsPerIO = 6


def generateHTMLForProductTerms(LABCount, bitOffset=0):

    template = """
<h2>Product terms</h2>
The device contains {:d} Logic Array Blocks (LABs), each containing 16 macrocells.
Every macrocell can use between 0 and 5 product terms to calculate a sum-of-products.
Each of those product terms can use up to {:d} different input signals choosable from {:d} nets to calculate a product.
To enable the inclusion of a net into a product term, the corresponding bit in the bitstream must be toggled:
A '1' represents a disregarded signal, a '0' appends the signal to the product.
Therefore, each product term is configured by {:d} bits and {:d} bits of the bitstream configure all the device's product terms.
The product term configuration bits appear clustered in the bitstream and in the following order:
product term 1 first - 5 last, macrocell 1 first - 16 last, LAB A first - B last.
Within one product term the earlier 72 bits switch global signals:
36 global signals are routed to each LAB from the PIA.
Two consecutive bits switch one of those global signals - the first bit non-inverted, the second inverted.
Another 16 bits switch regional foldback signals from outputs of macrocells within the same LAB.
"""

    html = template.format(
                LABCount,
                int(BitsPerProductTerm/2),
                BitsPerProductTerm,
                BitsPerProductTerm,
                LABCount*MacrocellsPerLAB*ProductTermsPerMacrocell*BitsPerProductTerm,
                BitsPerProductTerm
                )

    # Rows in bit table
    tr = ""

    for lab in range(LABCount):
        labChar = chr(ord('A') + lab)
        labString = "LAB "+labChar
        tr += "<tr><td rowspan=" + str(MacrocellsPerLAB*ProductTermsPerMacrocell) + ">"+labString+"</td>\n"
        for macrocell in range(MacrocellsPerLAB):
            macrocellIndex = (lab * MacrocellsPerLAB) + macrocell
            s = "Macrocell "+str(macrocellIndex+1)
            tr += "<td rowspan=" + str(ProductTermsPerMacrocell) + " title=\""+s+", which lies in "+labString+"\">"+s+"</td>\n"
            for pt in range(ProductTermsPerMacrocell):
                if pt > 0:
                    tr += "<tr>"
                ptString = str(pt+1)
                tr += "<td title=\"Product term "+ptString+"\">PT"+ptString+"</td>\n"
                for bit in range(BitsPerProductTerm):
                    if bit < 36*2:
                        # Global signal
                        symbol = "G" # + str(int(bit/2)+1)
                    else:
                        # Regional foldback signal
                        symbol = "R"
                    tr += "<td title=\"Bit "+str(bitOffset+bit)+"\">"+symbol+"</td>\n"
                bitOffset += BitsPerProductTerm
                tr += "</tr>\n"

    return (html, tr, bitOffset)


def generateHTMLForMacrocellConfiguration(LABCount, bitOffset):

    bitsPerMacrocell = 13
    MacrocellCount = LABCount * MacrocellsPerLAB
    bitCount = MacrocellCount * 13
    byteCount = int(bitCount/8)

    template = """
<h2>Macrocell configuration</h2>

In this context by macrocell configuration it is referred to everything configurable
between product terms and macrocell input/output signal.

The macrocell bits are expected to configure:
<ul>
<li>Select product terms: Probably five bits, one per product term</li>
<li>Select logic type: Combinatorial (latch) or flip-flop (at least one bit)</li>
<li>Select D-FF clock signal: GCLK1 or GCLK2 or a product term (at least two bits)</li>
<li>Select D-FF enable signal: None or OE1 or OE2 or product term? (two bits?)</li>
<li>Select D-FF clear signal: None or GCLR or product term (two bits?)</li>
<li>Enable parallel expander input (one bit?)</li>
</ul>

It appears, {:d} bits configure one macrocell.
With {:d} LABs this makes for {:d} bits ({:d} bytes) in total for macrocell configuration.

<h3>Preliminary configuration bit order</h3>

It seems, the macrocell configuration bits appear in the following order in the bitstream:
<table>
<tbody>
<tr>
<td title="Bit 1: Enable PT1 to OR switch">PT1E</td>
<td title="Bit 2: Enable PT2 to OR switch">PT2E</td>
<td title="Bit 3: Enable PT3 to OR switch">PT3E</td>
<td title="Bit 4: Enable PT4 to OR switch">PT4E</td>
<td title="Bit 5: Enable PT5 to OR switch">PT5E</td>
<td title="Bit 6: Enable global clock usage">GCLKE</td>
<td title="Bit 7: Enable global clear usage">GCLRE</td>
<td title="Bits 8-10: Unknown function" colspan=3>???</td>
<td title="Bit 11: Select registered or latched output">RLS</td>
<td title="Bit 13: Select global clock">GCLK</td>
</tr>
</tbody>
</table>

<ul>
<li>PT1E: Enable inclusion of product term 1 in the sum</li>
<li>PT2E: Enable inclusion of product term 2 in the sum</li>
<li>PT3E: Enable inclusion of product term 3 in the sum</li>
<li>PT4E: Enable inclusion of product term 4 in the sum</li>
<li>PT5E: Enable inclusion of product term 5 in the sum</li>
</ul>
"""

    html = template.format(
                bitsPerMacrocell,
                LABCount,
                bitCount,
                byteCount
                )

    tr = ""
    for i in range(MacrocellCount):
        labChar = chr(ord('A') + (i / MacrocellsPerLAB))
        tr += "<tr><td>LAB {:s}</td>".format(labChar)
        tr += "<td colspan=2>Macrocell {:d}</td>".format(i+1)
        tr += "<td colspan={:d}>M</td>".format(bitsPerMacrocell)
        bitOffset += bitsPerMacrocell
        tr += "</tr>\n"

    return (html, tr, bitCount)


def generateHTMLForPIAtoLABrouting(LABCount, PIAtoLABmuxCount, bitOffset):

    html = "<h2>Selection of global signals for a LAB (PIA-to-LAB routing)</h2>\n"
    html += "Every LAB can use "+str(GlobalSignalsPerLAB)+" global signals by routing them to the LAB from the PIA.\n"
    html += "A global signal is selected by enabling the corresponding switch/multiplexer: One bit switches one signal. A '1' bit disables a PIA signal, a '0' bit enables it.\n"
    html += "Caveat: Enabling multiple switches for one LAB signal may permanently damage the device.<br/>\n"
    bitCount = LABCount * GlobalSignalsPerLAB * PIAtoLABmuxCount
    byteCount = int(bitCount/8)
    html += "Every LAB signal can be selected from "+str(PIAtoLABmuxCount)+" choices. With one bit per choice this makes for "+str(GlobalSignalsPerLAB*PIAtoLABmuxCount)+" bits per LAB and "+str(bitCount)+" bits ("+str(byteCount)+" bytes) in total for PIA to LAB routing configuration.\n"
    html += "Assuming that every switch/multiplexer selects a different PIA signal, a maximum of {:d} PIA signals is routable to one LAB.<br/>\n".format(GlobalSignalsPerLAB*PIAtoLABmuxCount)

    tr = ""
    for i in range(LABCount):
        labChar = chr(ord('A') + i)
        tr += "<tr><td>LAB {:s}</td><td colspan=2>PIA-Mux {:d}-{:d}</td>".format(labChar, i*GlobalSignalsPerLAB+1, (i+1)*GlobalSignalsPerLAB)
        for j in range(GlobalSignalsPerLAB):
            tr += "<td colspan=\"{:d}\" title=\"Bits {:d}-{:d}\">P</td>".format(PIAtoLABmuxCount, bitOffset, bitOffset+PIAtoLABmuxCount-1)
            bitOffset += PIAtoLABmuxCount
        tr += "</tr>\n"

    return (html, tr, bitCount)


def generateHTMLForOEConfiguration(bitOffset, selectionBitCount=4):
    html = """
<h2>Selection of output enable signals</h2>

Every I/O pin can select one of six global signals as output enable signal (tri-state control signal).<br/>
<br/>
The output enable signals are usually active high: When the signal of is low, the pin is in high-impedance state.
When it is high, the pin assumes the logic level defined by the output of the corresponding macrocell.
It is also possible to use an inverted output enable signal and thus realize active-low output enable function.<br/>
<br/>
A total of 6 global output enable signals are available,
which somehow can be chosen from PIA signals,
probably similar to the way signals are routed to a LAB:
One bit selects one PIA signal as OE signal. A '1' bit indicates a disregarded signal, a '0' bit selects a PIA signal as output enable signal.
Caveat: Enabling multiple switches for one LAB signal may permanently damage the device.<br/>
<br/>
It appears, that {:d} bits select, which PIA signal is used as global output enable signal.
A {:d}th bit indicates, whether the signal is used non-inverted or inverted.
""".format(selectionBitCount, selectionBitCount+1)

    tr = """<tr>
<td colspan=3>Unknown function</td>
"""
    for i in range(22):
        tr += "<td>?</td>\n"

    tr += "</tr>"

    return (html, tr, 22*8)


def generateHTMLForIOConfiguration(IOCount, bitOffset):

    template = """
<h2>I/O configuration</h2>

{:d} bits configure one I/O block(?).
With {:d} I/O blocks this would make for {:d} bits ({:d} bytes) in total for I/O configuration.
"""

    bitCount = IOCount * BitsPerIO
    byteCount = int(bitCount/8)

    html = template.format(
                BitsPerIO,
                IOCount,
                bitCount,
                byteCount
                )

    html += """
<table>
<tbody>
<tr>
<td title="Output enable select" colspan=3>OES</td>
<td title="Slew rate select">SRS</td>
<td>?</td>
<td>?</td>
</tr>
</tbody>
</table>

<ul>
<li>Bits 1,2,3: Output enable select</li>
<li>Bit 4: Slew rate, 0=fast, 1=slow</li>
<li>Bit 5,6: ?</li>
</ul>
"""

    tr = ""
    for i in range(IOCount):
        labChar = chr(ord('A') + (i / MacrocellsPerLAB))
        s = "I/O block {:d}".format(i+1)
        symbol = "IO"
        tr += "<tr><td colspan=3>{:s}</td>".format(s)
        #tr += "<td>LAB {:s}</td>".format(labChar)
        #tr += "<td colspan=2>IO {:d}</td>".format(i+1)
        tr += "<td colspan={:d} title=\"Bits {:d}-{:d}\">{:s}</td>".format(6, bitOffset, bitOffset+6-1, symbol)
        bitOffset += 6
        tr += "</tr>\n"

    #return (html, tr, bitCount)
    return (html, tr, 62*6)


def generateHTMLForUsercode(bitOffset):
    html = """
<h2>Usercode</h2>

A 16-bit user electronic signature (usercode) is stored in the bitstream.
It occupies it's last 16 bits.
It's bits and bytes are in reversed order (additionally to the reversed order that bits are stored in a POF file).

<h3>Example</h3>
<table>
<tr>
<td rowspan=2>Last 3 bytes of the bitstream payload in the POF file</td>
<td>0x9a</td>
<td>0x57</td>
<td>0x01</td>
</tr>
<tr>
<td class=binary>1001 1010</td>
<td class=binary>0101 0111</td>
<td class=binary>0000 0001</td>
</tr>
<tr>
<td rowspan=2>Bitstream bit order</td>
<td class=binary>0101 1001</td>
<td class=binary>1110 1010</td>
<td class=binary>1000 0000</td>
</tr>
<tr>
<td colspan=3 class=binary>0101 1001 1110 1010 1000 0000</td>
</tr>
<tr>
<td>Last 16 bits of the bitstream</td>
<td colspan=3 class=binary>1011 0011 1101 0101</td>
</tr>
<tr>
<td>Inverted bit order</td>
<td colspan=3 class=binary>1010 1011 1100 1101</td>
</tr>
<tr>
<td>Usercode</td>
<td colspan=3>0xABCD</td>
</tr>
</table>
"""

    tr = "<tr><td colspan=3>Usercode</td>"
    tr += "<td colspan=16 title=\"Bits {:d}-{:d}\">Bits {:d}-{:d}</td>".format(bitOffset+16, bitOffset, 16, 1)
    bitOffset += 16
    tr += "</tr>\n"

    return (html, tr, 16)


def generateHTMLForExtraBits(count, bitOffset):
    html = "<h2>Unidentified extra bits</h2>\nTODO"
    tr = "<tr><td colspan=3>Extra bits</td>"
    for i in range(count):
        tr += "<td title=\"{:d}\">?</td>".format(bitOffset)
        bitOffset += 1
    tr += "</tr>\n"
    return (html, tr, count)
