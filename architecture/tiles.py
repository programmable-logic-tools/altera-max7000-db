#!/usr/bin/python3

class Tile:
    def __init__(self):
        self.type = "empty"
        self.comment = "empty"
        self.rowspan = 1

class MAX_IO(Tile):
    def __init__(self):
        self.type = "MAX_IO"
        self.comment = "I/O block"
        self.rowspan = 1

class MAX_INPUT(Tile):
    def __init__(self):
        self.type = "MAX_INPUT"
        self.comment = "Dedicated input"
        self.rowspan = 1

class MAX_MCELL(Tile):
    def __init__(self):
        self.type = "MAX_MCELL"
        self.comment = "SOP + D-FF"
        self.rowspan = 1

class MAX_SEXP(Tile):
    def __init__(self):
        self.type = "MAX_SEXP"
        self.comment = "Serial expander"
        self.rowspan = 1

class MAX_GRP(Tile):
    def __init__(self, rowspan=16):
        self.type = "MAX_GRP"
        self.comment = "Global routing pool"
        self.rowspan = rowspan

