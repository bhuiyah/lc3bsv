`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2023 06:46:08 PM
// Design Name: 
// Module Name: LC3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

package packaged_functions;
    function automatic [15:0] sext(input [15:0] A, input [4:0] num_bits); 

        reg sign_bit;
        reg [15:0] mask;

        sign_bit = A[num_bits - 1] && 1;
        if(sign_bit) begin
            mask = {16'hFFFF << num_bits};
            sext = A | mask;
        end
        else begin
            sext = A;
        end
        return sext;
    endfunction
endpackage

import packaged_functions::*;

module LC3(clk);

input clk;

wire cs;
wire [1:0] we;
wire [15:0] address;
wire [15:0] memory_bus;
wire [34:0] control_signals;
wire r;
wire [3:0] opcode;
wire ir11;
wire ben;
wire slow_clk;
wire [5:0] state_number;
wire [5:0] next_state_number;
wire rw;

memory mem(.cs(cs), .we(we), .clk(clk), .rw(rw), .address(address), .memory_bus(memory_bus), .r(r));
datapath lc3(.clk(clk), .cs(cs), .we(we), .address(address), .memory_bus(memory_bus), .control_signals(control_signals), .opcode(opcode), .ir11(ir11), .ben(ben), .rw(rw), .r(r));
control cont(.clk(clk), .r(r), .opcode(opcode), .ir11(ir11), .ben(ben), .state_number(state_number), .next_state_number(next_state_number), .control_signals(control_signals));

endmodule
