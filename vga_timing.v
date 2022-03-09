`timescale 1ns / 1ps

//http://tinyvga.com/vga-timing

module vga_timing(
        input  wire        vgaClk,
        output wire [11:0] x, y,
        output wire        hsync, vsync, valid
    );
    reg [11:0] h_count, v_count;
    reg valid_reg, hsync_reg, vsync_reg;
    
    //parameters are for 1280x1024, 108MHz clock
    localparam h_fs  = 1688;
    localparam h_vis = 1280;
    localparam h_fp  = 48;
    localparam h_sp  = 112;
    localparam h_bp  = 248; //not used
    localparam h_pol = 1'b1; 
    
    localparam v_fs  = 1066;
    localparam v_vis = 1024;
    localparam v_fp  = 1;
    localparam v_sp  = 3;
    localparam v_bp  = 38;
    localparam v_pol = 1'b1; //positive
    
    initial begin
        hsync_reg <= ~h_pol;
        vsync_reg <= ~v_pol;
    end
    
    always @ (posedge vgaClk)begin  //make valid signal
        if(h_count < 1280 && v_count < 1024) valid_reg <= 1;
        else valid_reg <=0;
    end
    //////////////////////////////////////////////////////
    always @(posedge vgaClk)begin
        h_count <= h_count + 1;
        if(h_count == h_fs)begin
            h_count <= 0;
            v_count <= v_count + 1;
            if(v_count == v_fs) v_count <= 0;
        end
    end
    
    always @(posedge vgaClk)begin
        //now for vsync and hsync
        if(h_count >= (h_fp + h_vis - 1) && h_count < (h_fp + h_vis + h_sp - 1)) hsync_reg <= h_pol;
        else hsync_reg <= !h_pol;
        
        if(v_count > (v_fp + v_vis - 1) && v_count < (v_fp + v_vis + v_sp - 1))vsync_reg <= v_pol;
        else vsync_reg <= !v_pol;      
        
    end
    //////////////////////////////////////////////////////
    assign x = h_count;
    assign y = v_count;
    assign valid = valid_reg;
    assign vsync = vsync_reg;
    assign hsync = hsync_reg;
    
endmodule   //vga_timing///////////////////////////////////////

