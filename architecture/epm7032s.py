#!/usr/bin/python3
#
# This script generates the tile grid for an Altera EPM7032S CPLD
#

from grid import *
from tiles import *


class Grid_EPM7032S(Grid):
    def __init__(self):
        self.sizex = 7
        self.sizey = 17
        self.clearGrid()

        # Generate LAB1 and LAB2 tiles
        for y in range(1,17):
            self.setTile(0, y, MAX_IO())
            self.setTile(1, y, MAX_MCELL())
            self.setTile(2, y, MAX_SEXP())
            self.setTile(4, y, MAX_SEXP())
            self.setTile(5, y, MAX_MCELL())
            self.setTile(6, y, MAX_IO())

        # Add global routing pool
        self.setTile(3, 1, MAX_GRP(rowspan=16))

        # Add dedicated input pins
        for x in [1, 2, 4, 5]:
            self.setTile(x, 0, MAX_INPUT())


if __name__ == "__main__":
    g = Grid_EPM7032S()
    file_prefix = "epm7032s"

    # Export XML file
    f = open(file_prefix+".xml", "w")
    f.write(g.xml())
    f.close()

    # Export HTML file
    f = open(file_prefix+".html", "w")
    f.write(g.html())
    f.close()
