//////////////////////////////////////////////////////////////////////
////                                                              ////
////  uart_defines.v                                              ////
////                                                              ////
////                                                              ////
////  This file is part of the "UART 16550 compatible" project    ////
////  http://www.opencores.org/cores/uart16550/                   ////
////                                                              ////
////  Documentation related to this project:                      ////
////  - http://www.opencores.org/cores/uart16550/                 ////
////                                                              ////
////  Projects compatibility:                                     ////
////  - WISHBONE                                                  ////
////  RS232 Protocol                                              ////
////  16550D uart (mostly supported)                              ////
////                                                              ////
////  Overview (main Features):                                   ////
////  Defines of the Core                                         ////
////                                                              ////
////  Known problems (limits):                                    ////
////  None                                                        ////
////                                                              ////
////  To Do:                                                      ////
////  Nothing.                                                    ////
////                                                              ////
////  Author(s):                                                  ////
////      - gorban@opencores.org                                  ////
////      - Jacob Gorban                                          ////
////      - Igor Mohor (igorm@opencores.org)                      ////
////                                                              ////
////  Created:        2001/05/12                                  ////
////  Last Updated:   2001/05/17                                  ////
////                  (See log for the revision history)          ////
////                                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000, 2001 Authors                             ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.13  2003/06/11 16:37:47  gorban
// This fixes errors in some cases when data is being read and put to the FIFO at the same time. Patch is submitted by Scott Furman. Update is very recommended.
//
// Revision 1.12  2002/07/22 23:02:23  gorban
// Bug Fixes:
//  * Possible loss of sync and bad reception of stop bit on slow baud rates fixed.
//   Problem reported by Kenny.Tung.
//  * Bad (or lack of ) loopback handling fixed. Reported by Cherry Withers.
//
// Improvements:
//  * Made FIFO's as general inferrable memory where possible.
//  So on FPGA they should be inferred as RAM (Distributed RAM on Xilinx).
//  This saves about 1/3 of the Slice count and reduces P&R and synthesis times.
//
//  * Added optional baudrate output (baud_o).
//  This is identical to BAUDOUT* signal on 16550 chip.
//  It outputs 16xbit_clock_rate - the divided clock.
//  It's disabled by default. Define UART_HAS_BAUDRATE_OUTPUT to use.
//
// Revision 1.10  2001/12/11 08:55:40  mohor
// Scratch register define added.
//
// Revision 1.9  2001/12/03 21:44:29  gorban
// Updated specification documentation.
// Added full 32-bit data bus interface, now as default.
// Address is 5-bit wide in 32-bit data bus mode.
// Added wb_sel_i input to the core. It's used in the 32-bit mode.
// Added debug interface with two 32-bit read-only registers in 32-bit mode.
// Bits 5 and 6 of LSR are now only cleared on TX FIFO write.
// My small test bench is modified to work with 32-bit mode.
//
// Revision 1.8  2001/11/26 21:38:54  gorban
// Lots of fixes:
// Break condition wasn't handled correctly at all.
// LSR bits could lose their values.
// LSR value after reset was wrong.
// Timing of THRE interrupt signal corrected.
// LSR bit 0 timing corrected.
//
// Revision 1.7  2001/08/24 21:01:12  mohor
// Things connected to parity changed.
// Clock devider changed.
//
// Revision 1.6  2001/08/23 16:05:05  mohor
// Stop bit bug fixed.
// Parity bug fixed.
// WISHBONE read cycle bug fixed,
// OE indicator (Overrun Error) bug fixed.
// PE indicator (Parity Error) bug fixed.
// Register read bug fixed.
//
// Revision 1.5  2001/05/31 20:08:01  gorban
// FIFO changes and other corrections.
//
// Revision 1.4  2001/05/21 19:12:02  gorban
// Corrected some Linter messages.
//
// Revision 1.3  2001/05/17 18:34:18  gorban
// First 'stable' release. Should be sythesizable now. Also added new header.
//
// Revision 1.0  2001-05-17 21:27:11+02  jacob
// Initial revision
//
//

// Uncomment this if you want your UART to have
// 16xBaudrate output port.
// If defined, the enable signal will be used to drive baudrate_o signal
// It's frequency is 16xbaudrate

// `define UART_HAS_BAUDRATE_OUTPUT

// Register addresses (DLAB == 0)
// Offset 0x0 - receiver buffer
`define UART_REG_RB	3'd0
// Offset 0x0 - transmitter buffer
`define UART_REG_TR  3'd0
// Offset 0x1 - Interrupt enable
`define UART_REG_IE	3'd1
// Offset 0x2 - Interrupt identification
`define UART_REG_II  3'd2
// Offset 0x2 - FIFO control
`define UART_REG_FC  3'd2
// Offset 0x3 - Line control
`define UART_REG_LC	3'd3
// Offset 0x4 - Modem control
`define UART_REG_MC	3'd4
// Offset 0x5 - Line status
`define UART_REG_LS  3'd5
// Offset 0x6 - Modem status
`define UART_REG_MS  3'd6
// Offset 0x7 - Scratch register
`define UART_REG_SR  3'd7

// Register addresses (DLAB == 1)
// Offset 0x0 - Divisor latch byte lower
`define UART_REG_DL1	3'd0
// Offset 0x1 - Divisor latch byte upper
`define UART_REG_DL2	3'd1

// Interrupt Enable (IE) register bits
// RDA  - Received Data Available interrupt
`define UART_IE_RDA  0
// THRE - Transmitter Holding Register Empty interrupt
`define UART_IE_THRE 1
// RLS  - Receiver Line Status interrupt
`define UART_IE_RLS  2
// MS   - Modem Status interrupt
`define UART_IE_MS   3

// Interrupt Identification (II) register bits
// IP   - Interrupt pending when 0
`define UART_II_IP   0
// II   - Interrupt identification
`define UART_II_II 3:1

// II_II- Interrupt identification values for bits 3:1
// MS   - Modem Status
`define UART_II_MS   3'b000
// THRE - Transmitter Holding Register Empty
`define UART_II_THRE 3'b001
// RDA  - Receiver Data Available
`define UART_II_RDA  3'b010
// RLS  - Receiver Line Status
`define UART_II_RLS	 3'b011
// TI   - Timeout Indication
`define UART_II_TI	 3'b110

// FIFO Control (FC) register bits
// TL   - Trigger level
`define UART_FC_TL	1:0

// FIFO trigger level values
`define UART_FC_1  2'b00
`define UART_FC_4  2'b01
`define UART_FC_8  2'b10
`define UART_FC_14 2'b11

// Line Control (LC) register bits
// BITS - bits in character
`define UART_LC_BITS 1:0
// SB   - Stop Bits
`define UART_LC_SB   2
// PE   - Parity Enable
`define UART_LC_PE   3
// EP   - Even Parity
`define UART_LC_EP   4
// SP   - Stick Parity
`define UART_LC_SP   5
// BC   - Break Control
`define UART_LC_BC   6
// DL   - Divisor Latch Access Bit aka DLAB
`define UART_LC_DL   7

// Modem Control register bits
`define UART_MC_DTR  0
`define UART_MC_RTS  1
`define UART_MC_OUT1 2
`define UART_MC_OUT2 3
// LoopBack mode
`define UART_MC_LB   4

// Line Status Register bits
// Data ready
`define UART_LS_DR  0
// Overrun Error
`define UART_LS_OE  1
// Parity Error
`define UART_LS_PE  2
// Framing Error
`define UART_LS_FE  3
// Break interrupt
`define UART_LS_BI  4
// Transmit FIFO is empty
`define UART_LS_TFE 5
// Transmitter Empty indicator
`define UART_LS_TE  6
// Error indicator
`define UART_LS_EI  7

// Modem Status Register bits
// Delta signals
`define UART_MS_DCTS 0
`define UART_MS_DDSR 1
`define UART_MS_TERI 2
`define UART_MS_DDCD 3
// Complement signals
`define UART_MS_CCTS 4
`define UART_MS_CDSR 5
`define UART_MS_CRI  6
`define UART_MS_CDCD 7

// FIFO parameter defines

`define UART_FIFO_WIDTH 8
`define UART_FIFO_DEPTH 16
`define UART_FIFO_POINTER_W 4
`define UART_FIFO_COUNTER_W 5
// receiver fifo has width 11 because it has break, parity and framing error bits
`define UART_FIFO_REC_WIDTH 11

// All activity on the WISHBONE is recorded
`define VERBOSE_WB 0
// Details about the lsr (line status register)
`define VERBOSE_LINE_STATUS 0
// 64/1024 packets are sent
`define FAST_TEST 1
