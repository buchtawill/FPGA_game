`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2022 01:24:05 PM
// Design Name: 
// Module Name: amongUsAnimation
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


module amongUsAnimation(
        input  wire vgaClk,
        input  wire [11:0] x, y,
        output wire [11:0] color_data
    );
    
    reg [4:0]  frameCounter;
    reg [11:0] rgb_reg;
    wire frameClk;
    wire [11:0] frame1, frame2, frame3, frame4, frame5, frame6, frame7, frame8, frame9, frame10, frame11, frame12;
    wire [11:0] frame13, frame14, frame15, frame16, frame17, frame18, frame19, frame20, frame21; 
    
    frame1_rom  rom1 (.color_val(frame1),  .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame2_rom  rom2 (.color_val(frame2),  .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame3_rom  rom3 (.color_val(frame3),  .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame4_rom  rom4 (.color_val(frame4),  .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame5_rom  rom5 (.color_val(frame5),  .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame6_rom  rom6 (.color_val(frame6),  .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame7_rom  rom7 (.color_val(frame7),  .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame8_rom  rom8 (.color_val(frame8),  .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame9_rom  rom9 (.color_val(frame9),  .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame10_rom rom10(.color_val(frame10), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame11_rom rom11(.color_val(frame11), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame12_rom rom12(.color_val(frame12), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame13_rom rom13(.color_val(frame13), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame14_rom rom14(.color_val(frame14), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame15_rom rom15(.color_val(frame15), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame16_rom rom16(.color_val(frame16), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame17_rom rom17(.color_val(frame17), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame18_rom rom18(.color_val(frame18), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame19_rom rom19(.color_val(frame19), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame20_rom rom20(.color_val(frame20), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    frame21_rom rom21(.color_val(frame21), .col(x[9:4]), .row(y[9:4]), .clk(vgaClk));
    
    clkMaker frameClockMaker(.clk(vgaClk), .gameClk(frameClk));
    
    
    always@(posedge vgaClk)begin
    if(x<1024)begin
        case(frameCounter)
            0:  rgb_reg <= frame1;
            1:  rgb_reg <= frame2;
            2:  rgb_reg <= frame3;
            3:  rgb_reg <= frame4;
            4:  rgb_reg <= frame5;
            5:  rgb_reg <= frame6;
            6:  rgb_reg <= frame7;
            7:  rgb_reg <= frame8;
            8:  rgb_reg <= frame9;
            9:  rgb_reg <= frame10;
            10: rgb_reg <= frame11;
            11: rgb_reg <= frame12;
            12: rgb_reg <= frame13;
            13: rgb_reg <= frame14;
            14: rgb_reg <= frame15;
            15: rgb_reg <= frame16;
            16: rgb_reg <= frame17;
            17: rgb_reg <= frame18;
            18: rgb_reg <= frame19;
            19: rgb_reg <= frame20;
            20: rgb_reg <= frame21;
            21: rgb_reg <= 12'b111111111111;
        endcase
        end
        else rgb_reg <= 12'b111111111111;
    end
    
    always @(posedge frameClk)begin
        frameCounter <= frameCounter + 1;
        if(frameCounter > 20) frameCounter <= 0;  
    end
    
    assign color_data = rgb_reg;
    
endmodule///////////////////////////////////////////////////////////


module clkMaker(        //produces a ~48 Hz clock for the frames to switch
    input  wire clk,
    output wire gameClk
);
    reg outputReg;
    reg [20:0] counter;
    always @(posedge clk)begin
        if(counter == 0) outputReg <= !outputReg;
        counter <= counter + 1;
    end
    assign gameClk = outputReg;
endmodule
