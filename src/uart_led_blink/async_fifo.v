//==============================================================================
// Author: Erik Anderson
// Description: Structural verilog for asynchronous fifo (adapted from
// Sunburst Design's "Simulation and Synthesis Techniques for Asynchronous
// FIFO Design"). This version does not have as many checks as the fifo
// described in the paper. 
// NOTE: The key principle behind this fifo is the passing of read and write
// pointers between the two domains using gray coded ptrs passed through
// multi-bit synchronizers. We know that the write side can only add data to
// the buffer and thus there may be some delay in telling the read side that
// another piece of data is available but before this delay the read side will 
// think the buffer is empty which is not a problem. Similary, the read side can 
// only tell the write said that a piece of data has been read but before then 
// the write side will see that the buffer is full which is also not a problem.
// NOTE: The true clock domain crossing is the write data to the read
// register. We can be sure that the read register will properly clock in the 
// data because the pointers ensure that the write side does not overwrite the 
// data before we can read it. The rptr_empty and wptr_full modules also synchronize
// the reading and writing of the memory into the appropriate clock domains
// once the rptr/wptr has been synchronized and compared.
// outputting of the data in the read domain
// NOTE: All signals with i/o_r* in front of the name are in the read clock
// domain and all signals with i/o_w* in front of the name are in the write
// clock domain. 
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

`timescale 1ns/1ps
`default_nettype none

module async_fifo (
    i_rclk,
    i_rrst,
    i_ren,
    o_rdata,
    o_rempty,
    i_wclk,
    i_wrst,
    i_wen,
    i_wdata,
    o_wfull,
);

//-----------------------------------------------------------------------------------
// Parameters 
//-----------------------------------------------------------------------------------
parameter DataSize = 8;
parameter AddressSize = 4;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// I/O 
//-----------------------------------------------------------------------------------
// Read interface
input wire i_rclk;
input wire i_rrst;
input wire i_ren;
output wire [DataSize-1:0] o_rdata;
output wire o_rempty;

// Write interface
input wire i_wclk;
input wire i_wrst;
input wire i_wen;
input wire [DataSize-1:0] i_wdata;
output wire o_wfull;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Signals
//-----------------------------------------------------------------------------------
wire [AddressSize:0] rptr, wptr;
wire [AddressSize:0] rptr_sync, wptr_sync;
wire [AddressSize-1:0] raddr, waddr;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Read-to-write synchronizer 
//-----------------------------------------------------------------------------------
synchronizer #(
    .DataSize(AddressSize+1)
) rd_to_wr_sync (
    .i_clk(i_wclk),
    .i_rst(i_wrst),
    .i_data(rptr),
    .o_data(rptr_sync)
);
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Write-to-read synchronizer 
//-----------------------------------------------------------------------------------
synchronizer #(
    .DataSize(AddressSize+1)
) wr_to_rd_sync (
    .i_clk(i_rclk),
    .i_rst(i_rrst),
    .i_data(wptr),
    .o_data(wptr_sync)
);
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// FIFO memory 
//-----------------------------------------------------------------------------------
fifo_memory #(
    .DataSize(DataSize), 
    .AddressSize(AddressSize)
) fifo_memory (
    .o_rdata(o_rdata),
    .i_wdata(i_wdata),
    .i_waddr(waddr),
    .i_raddr(raddr),
    .i_wen(i_wen),
    .i_wfull(o_wfull),
    .i_wclk(i_wclk)
);
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Read ptr empty generator 
//-----------------------------------------------------------------------------------
rptr_empty #(
    .AddressSize(AddressSize)
) rptr_empty (
    .i_rclk(i_rclk),
    .i_rrst(i_rrst),
    .i_ren(i_ren),
    .i_wptr_gray_sync(wptr_sync),
    .o_rptr_gray(rptr),
    .o_raddr(o_raddr),
    .o_rempty(o_rempty)
);
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Write ptr full generator 
//-----------------------------------------------------------------------------------
wptr_full #(
    .AddressSize(AddressSize)
) wptr_full (
    .i_wclk(i_wclk),
    .i_wrst(i_wrst),
    .i_wen(i_wen),
    .i_rptr_gray_sync(rptr_sync),
    .o_wptr_gray(wptr),
    .o_waddr(waddr),
    .o_wfull(o_wfull)
);
//-----------------------------------------------------------------------------------

endmodule

`default_nettype wire 
