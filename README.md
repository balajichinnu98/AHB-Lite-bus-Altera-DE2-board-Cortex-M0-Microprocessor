# AHB-Lite-bus-Altera-DE2-board-Cortex-M0-Microprocessor


AHB-Lite-bus-Altera-DE2-board-Microprocessor
Altera DE2 Board - Cortex M0 core

The design is expanded besides to driving the LEDs an additional AHB-Lite slave is created, in verilog that drives the eight 7 segments LEDs on the board. 7 segment decoding so that when a 32 bit number is written to the register location the 32 bit number is displayed,in hexadecimal,on all eight 7 segment LEDs. It is possible to write to and also read from the register. ARM assembler that displays the hex value of the student ID on the 7 segment display. Register is accessible via the memory address 0x52000000, key = Key[2], interrupt = 14.
