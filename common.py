#!/usr/bin/python

MacrocellsPerLAB = 16
ProductTermsPerMacrocell = 5
BitsPerProductTerm = 88


def generateTablesForProductTerms(LABCount):
    html = "Bits 0 through "+str(LABCount*MacrocellsPerLAB*ProductTermsPerMacrocell*BitsPerProductTerm-1)+" configure the product terms.\n<br/><br/>\n"

    html += "<table id=\"product-terms\">\n<tbody>\n"

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
