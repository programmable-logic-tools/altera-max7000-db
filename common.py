#!/usr/bin/python

MacrocellsPerLAB = 16
ProductTermsPerMacrocell = 5
BitsPerProductTerm = 88


def generateTablesForProductTerms(LABCount):
    html = "<table id=\"product-terms\">\n<tbody>\n"

    for lab in range(LABCount):
        html += "<tr><td rowspan=" + str(MacrocellsPerLAB*ProductTermsPerMacrocell) + ">LAB</td>\n"
        for macrocell in range(MacrocellsPerLAB):
            html += "<td rowspan=" + str(ProductTermsPerMacrocell) + ">Macrocell</td>\n"
            for orGate in range(ProductTermsPerMacrocell):
                if orGate > 0:
                    html += "<tr>"
                for bit in range(BitsPerProductTerm):
                    html += "<td alt=\"Bit "+str(bit)+"\">P</td>"
                html += "</tr>\n"

    html += "</tbody>\n</table>\n"
    return html
