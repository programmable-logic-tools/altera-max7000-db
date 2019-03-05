#!/usr/bin/python3

#
# Creates a HTML table for the provided array of bitstream partitions
#
def partitionsToTable(partitions):
    chapterPartitioning = """
<h2>Bitstream partitioning</h2>
<table>
<tr>
<th>Partition no.</th>
<th>Content</th>
<th>from bit</th>
<th>to bit (incl.)</th>
<th>Bit count</th>
<th>Calculation</th>
</tr>
"""
    
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
