#!/usr/bin/python

MacrocellsPerLAB = 16
ProductTermsPerMacrocell = 5
BitsPerProductTerm = 88


def generateTablesForProductTerms(LABCount):

    html = "The device contains "+str(LABCount)+" Logic Array Blocks (LABs), each containing 16 macrocells.<br/>\n"
    html += "Bits 0 through "+str(LABCount*MacrocellsPerLAB*ProductTermsPerMacrocell*BitsPerProductTerm-1)+" of the bitstream configure all of the device's product terms.<br/>\n"
    html += "Each product term is configured by "+str(BitsPerProductTerm)+" bits.\n"
    html += "A '1' represents a disregarded signal, a '0' appends the signal to the product.<br/>\n"
    html += "The lower 72 bits switch global signals, routed to the LAB from the PIA (36 signals, inverted and non-inverted).<br/>\n"
    html += "The higher 16 bits switch regional foldback signals, i.e. outputs from macrocells of the same LAB.<br>\n" 

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
                    html += "<td title=\"Bit "+str(offset+bit)+"\">P</td>"
                offset += BitsPerProductTerm
                html += "</tr>\n"

    html += "</tbody>\n</table>\n"
    return html
