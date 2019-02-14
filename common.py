#!/usr/bin/python

MacrocellsPerLAB = 16
ProductTermsPerMacrocell = 5
BitsPerProductTerm = 88


def generateHTMLForProductTerms(LABCount):

    html = "<h2>Product terms</h2>\n"
    html += "The device contains "+str(LABCount)+" Logic Array Blocks (LABs), each containing 16 macrocells.<br/>\n"
    html += "Bits 0 through "+str(LABCount*MacrocellsPerLAB*ProductTermsPerMacrocell*BitsPerProductTerm-1)+" of the bitstream configure all of the device's product terms.<br/>\n"
    html += "Each product term is configured by "+str(BitsPerProductTerm)+" bits.\n"
    html += "A '1' represents a disregarded signal, a '0' appends the signal to the product.<br/>\n"
    html += "The lower 72 bits switch global signals ('G'), routed to the LAB from the PIA (36 signals, once inverted and once non-inverted).<br/>\n"
    html += "The higher 16 bits switch regional foldback signals ('R'), i.e. outputs from macrocells of the same LAB.<br>\n"

    html += "\n<br/>\n<table id=\"product-terms\">\n<tbody>\n"

    offset = 0

    for lab in range(LABCount):
        labChar = chr(ord('A') + lab)
        labString = "LAB "+labChar
        html += "<tr><td rowspan=" + str(MacrocellsPerLAB*ProductTermsPerMacrocell) + ">"+labString+"</td>\n"
        for macrocell in range(MacrocellsPerLAB):
            macrocellIndex = (lab * MacrocellsPerLAB) + macrocell
            s = "Macrocell "+str(macrocellIndex+1)
            html += "<td rowspan=" + str(ProductTermsPerMacrocell) + " title=\""+s+", which lies in "+labString+"\">"+s+"</td>\n"
            for pt in range(ProductTermsPerMacrocell):
                if pt > 0:
                    html += "<tr>"
                ptString = str(pt+1)
                html += "<td title=\"Product term "+ptString+"\">PT"+ptString+"</td>"
                for bit in range(BitsPerProductTerm):
                    if bit < 36*2:
                        # Global signal
                        symbol = "G" # + str(int(bit/2)+1)
                    else:
                        # Regional foldback signal
                        symbol = "R"
                    html += "<td title=\"Bit "+str(offset+bit)+"\">"+symbol+"</td>"
                offset += BitsPerProductTerm
                html += "</tr>\n"

    html += "</tbody>\n</table>\n"
    return (html, offset)


def generateHTMLForMacrocellConfiguration(LABCount, bitOffset):

    html = "<h2>Macrocell configuration(?)</h2>\n"
    html += "The presumed macrocell configuration bits are organized per LAB half. Apparently, 104 consecutive bits configure 8 consecutive macrocells of one LAB.<br/>\n"
    bitCount = LABCount * 2 * 104
    byteCount = int(bitCount/8)
    html += "With "+str(LABCount)+" LABs this makes for "+str(bitCount)+" bits ("+str(byteCount)+" bytes) in total for macrocell configuration.<br/>\n"

    html += "\n<br/>\n<table id=\"macrocell-configuration\">\n<tbody>\n"
    # TODO...
    html += "</tbody>\n</table>\n"

    return (html, bitCount)


def generateHTMLForPIAtoLABrouting(LABCount, PIAtoLABmuxCount, bitOffset):
    return ("", 0)


def generateHTMLForIOConfiguration(IOCount, bitOffset):
    return ("", 0)

