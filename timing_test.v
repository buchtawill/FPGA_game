`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Me
// Engineer: Will Buchta
// 
// Create Date: 02/16/2022 04:51:57 PM
// Design Name: Amongus rom test
// Module Name: timing_test
// Project Name: 
// Target Devices: Basys3
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


module timing_test( //top module
        input  wire clk, reset,
		output wire hsync, vsync,
		output wire [11:0] rgb
    );
    wire        valid, vgaClk;
    wire [11:0] x,y;
    reg  [11:0] rgb_reg;
    wire [11:0] animeWires;
    
    clk_wiz_0 vga_maker(.clk_out1(vgaClk), .clk_in1(clk));
    
    vga_timing timingModule(.vgaClk(vgaClk), .x(x), .y(y), .valid(valid), .hsync(hsync), .vsync(vsync));
    
    amongUsAnimation anime(.vgaClk(vgaClk), .x(x), .y(y), .color_data(animeWires));
  
    
    always @ (posedge vgaClk)begin
        if(valid == 0) rgb_reg<=0;
        else begin
           if(x<1024) rgb_reg<=animeWires;
           else rgb_reg<=4095;  //white
        end
    end
    
    assign rgb = rgb_reg;
endmodule

