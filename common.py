#!/usr/bin/python

MacrocellsPerLAB = 16
ProductTermsPerMacrocell = 5
BitsPerProductTerm = 88
GlobalSignalsPerLAB = 36
BitsPerIO = 12


def generateHTMLForProductTerms(LABCount, bitOffset=0):

    html = "<h2>Product terms</h2>\n"
    html += "The device contains "+str(LABCount)+" Logic Array Blocks (LABs), each containing 16 macrocells.<br/>\n"
    html += "Bits 0 through "+str(LABCount*MacrocellsPerLAB*ProductTermsPerMacrocell*BitsPerProductTerm-1)+" of the bitstream configure the device's product terms.<br/>\n"
    html += "Each product term is configured by "+str(BitsPerProductTerm)+" bits.\n"
    html += "A '1' represents a disregarded signal, a '0' appends the signal to the product.<br/>\n"
    html += "The lower 72 bits switch global signals ('G'), routed to the LAB from the PIA (36 signals, once inverted and once non-inverted).<br/>\n"
    html += "The higher 16 bits switch regional foldback signals ('R'), i.e. outputs from macrocells of the same LAB.<br>\n"

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
                tr += "<td title=\"Product term "+ptString+"\">PT"+ptString+"</td>"
                for bit in range(BitsPerProductTerm):
                    if bit < 36*2:
                        # Global signal
                        symbol = "G" # + str(int(bit/2)+1)
                    else:
                        # Regional foldback signal
                        symbol = "R"
                    tr += "<td title=\"Bit "+str(bitOffset+bit)+"\">"+symbol+"</td>"
                bitOffset += BitsPerProductTerm
                tr += "</tr>\n"

    return (html, tr, bitOffset)


def generateHTMLForMacrocellConfiguration(LABCount, bitOffset):

    html = "<h2>Macrocell configuration</h2>\n"
    html += "13 bits configure one macrocell.\n"
    bitCount = LABCount * MacrocellsPerLAB * 13
    byteCount = int(bitCount/8)
    html += "With "+str(LABCount)+" LABs this makes for "+str(bitCount)+" bits ("+str(byteCount)+" bytes) in total for macrocell configuration.<br/>\n"

    # TODO...

    return (html, "", bitCount)


def generateHTMLForPIAtoLABrouting(LABCount, PIAtoLABmuxCount, bitOffset):

    html = "<h2>PIA-to-LAB routing configuration</h2>\n"
    html += "Every LAB can use "+str(GlobalSignalsPerLAB)+" global signals by routing them to the LAB from the PIA.<br/>\n"
    html += "A global signal is selected by enabling the corresponding switch/multiplexer: A '1' disables a PIA signal, a '0' enables it.<br/>\n"
    html += "Caveat: Enabling multiple switches for one LAB signal may damage the device.<br/>\n"
    bitCount = LABCount * GlobalSignalsPerLAB * PIAtoLABmuxCount
    byteCount = int(bitCount/8)
    html += "Every LAB signal can be selected from "+str(PIAtoLABmuxCount)+" choices. With one bit per choice this makes for "+str(GlobalSignalsPerLAB*PIAtoLABmuxCount)+" bits per LAB and "+str(bitCount)+" bits ("+str(byteCount)+" bytes) in total for PIA to LAB routing configuration.<br/>\n"
    html += "Assuming that every switch/multiplexer selects a different PIA signal, a maximum of "+str(GlobalSignalsPerLAB*PIAtoLABmuxCount)+" PIA signals are routable to a LAB.<br/>\n" 

    return (html, "", bitCount)


def generateHTMLForIOConfiguration(IOCount, bitOffset):

    html = "<h2>I/O pin configuration</h2>\n"
    html += str(BitsPerIO)+" bits configure one I/O block.\n"
    bitCount = IOCount * BitsPerIO
    byteCount = int(bitCount/8)
    html += "With "+str(IOCount)+" I/O blocks this makes for "+str(bitCount)+" bits ("+str(byteCount)+" bytes) in total for I/O configuration.<br/>\n"

    tr = ""
    bit = 0
    for i in range(IOCount):
        tr += """<tr><td class="empty"></td><td class="empty"></td><td class="empty"></td>"""
        for j in range(BitsPerIO):
            symbol = "IO"
            tr += "<td title=\"Bit "+str(bitOffset+bit)+"\">"+symbol+"</td>"
            bit += 1
        tr += "</tr>\n"

    return (html, tr, bitCount)

