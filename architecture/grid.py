#!/usr/bin/python3
#
# This class stores the tile grid
# of an FPGA or CPLD
#


class Grid:
    def __init__(self, sizex=1, sizey=1):
        self.sizex = sizex
        self.sizey = sizey
        self.clearGrid()

    def clearGrid(self):
        self.tiles = [[None for y in range(self.sizey)] for x in range(self.sizex)]

    def getTile(self, x, y):
        return self.tiles[x][y]

    def setTile(self, x, y, tile):
        self.tiles[x][y] = tile

    def html(self, html=True, css=True, body=True):
        result = ""
        if html:
            result += "<html>\n"
        if css:
            result += """<head>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>"""
        if body:
            result += "<body>\n"
        result += "<table class=tile-grid>\n"
        for y in range(self.sizey):
            result += "<tr>\n"
            for x in range(self.sizex):
                tile = self.getTile(x, y)
                if tile == None:
                    result += "<td class=empty></td>\n"
                    continue
                result += "<td class=tile rowspan=\"{:d}\">{:s}</td>\n".format(tile.rowspan, tile.type)
            result += "</tr>\n"
        result += "</table>\n"
        if body:
            result += "</body>\n"
        if html:
            result += "</html>\n"
        return result

    def xml(self):
        result = "<grid sizex={:d} sizey={:d}>\n".format(self.sizex, self.sizey)
        for x in range(self.sizex):
            for y in range(self.sizey):
                tile = self.getTile(x, y)
                if tile == None:
                    continue
                result += "<tile>{:s}</tile>\n".format(tile.type)
        result += "</grid>\n"
        return result
