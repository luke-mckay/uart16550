[![Documentation Status](https://readthedocs.org/projects/uart16550/badge/?version=latest)](https://uart16550.readthedocs.io/en/latest/?badge=latest)

UART16550
=========

The UART (Universal Asynchronous Receiver/Transmitter) core provides serial communication capabilities, 
which allow communication with modem or other external devices, like another computer using a serial
cable and RS232 protocol. This core is designed to be maximally compatible with the industry standard 
National Semiconductors' 16550A device.

**Features:**

1. Verilog based design
2. WISHBONE interface
3. Register level and functionality compatibility with 16550

Disclaimer
----------

This copy is presently a learning/development project.  The premise of the project is simple, but there
is a multitude of improvements that can be made.  Some of these are to modernize the project, some are
to fix existing bugs that people have indicated in the project, and other improvements can be done to
verify present functionality.  Feel free to create issues if you have suggestions, wants, or needs on
this core.

I've forked this project because I'm no expert in the art of digital design.  I'm a silicon validation 
engineer by day, i.e. I insure that designs do what they are supposed to do after they've reached 
silicon.  With that said I'm open to suggestions and course corrections that others may have. This
project provides me with a different perspective on the chip design process, and hopefully may provide
some improvements that could be useful for others.
