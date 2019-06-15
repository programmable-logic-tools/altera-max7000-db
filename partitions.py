#!/usr/bin/python3

#
# Creates a HTML table for the provided array of bitstream partitions
#
def partitionsToTable(partitions, deviceName, bitCount):
    chapterPartitioning = """
<h2>Bitstream overview</h2>

The bitstream for the {:s} consists of {:d} bits in total.<br/>

<table>
<tr>
<th></th>
<th>Function</th>
<th>from bit</th>
<th>to bit (incl.)</th>
<th>Bit count</th>
<th>Composed of</th>
</tr>
""".format(deviceName, bitCount)
    
    startBit = 1
    
    partitionNumber = 1
    for partition in partitions:
        row = "<tr>\n"
        
        row += "<td>{:d}</td>\n".format(partitionNumber)
        partitionNumber += 1
    
        row += "<td>{:s}</td>\n".format(partition["title"])
    
        row += "<td>{:d}</td>\n".format(startBit)
        row += "<td>{:d}</td>\n".format(startBit + partition["bitCount"] - 1)
        row += "<td>{:d}</td>\n".format(partition["bitCount"])
        startBit += partition["bitCount"]
    
        if "formula" in partition.keys():
            row += "<td>{:s}</td>\n".format(partition["formula"])
    
        row += "</tr>\n"
        chapterPartitioning += row
        
    chapterPartitioning += "</table>\n"
    return chapterPartitioning
