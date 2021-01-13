all: sim

.PHONY: all clean sim
sim:
	cd .. ;	fusesoc --cores-root=. run --target=sim uart16550
	cp -f ../build/uart16550_1.6.0/sim-icarus/uart_interrupts*.log .

clean:
	rm -rf ../build
