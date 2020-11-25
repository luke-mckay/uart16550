all: sim

.PHONY: all clean sim
sim:
	iverilog -f ./nc.scr 
	./a.out

clean:
	rm -f a.out