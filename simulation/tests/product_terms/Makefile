
#
# This Makefile executes the testbench contained in this folder
#

PATH = /home/code/Programmierbare-Logik/icarus/iverilog
IVERILOG = $(PATH)/driver/iverilog
VVP = $(PATH)/vvp/vvp
IVFLAGS := -I../../

SRCS = $(wildcard testbench*.v)
TESTBENCHES = $(SRCS:.v=.vvp)
WAVEFILES = $(TESTBENCHES:.vvp=.lx2)
WAVEPROJECTS = $(WAVEFILES:.lx2=.gtkw)


all: simulate

simulate: $(WAVEFILES)
%.vvp: %.v
	$(IVERILOG) $(IVFLAGS) -o $@ $<

%.lx2: %.vvp
	$(VVP) $^ -lxt2
	mv dump.lx2 $(^:.vvp=.lx2)

show: simulate $(WAVEPROJECTS)
%.gtkw: %.lx2
	gtkwave $@ &

clean:
	rm -f $(WAVEFILES) $(TESTBENCHES)
