`timescale 1ns / 1ps
`define RST_EN 1'b0

module vga_top #(
           parameter H_DISPLAY      = 11'd1024,
           parameter H_FRONT_PORCH  = 11'd24,
           parameter H_SYNC_PULSE   = 11'd136,
           parameter H_BACK_PORCH   = 11'd160,
           parameter H_TOTAL        = 11'd1344,

           parameter V_DISPLAY      = 10'd768,
           parameter V_FRONT_PORCH  = 10'd3,
           parameter V_SYNC_PULSE   = 10'd6,
           parameter V_BACK_PORCH   = 10'd29,
           parameter V_TOTAL        = 10'd806
       )(
           input  wire      clk,
           input  wire      rstn,

           output wire      hs,
           output wire      vs,
           output wire[3:0] red,
           output wire[3:0] green,
           output wire[3:0] blue
       );

// 65 MHz clock signal
wire clk_vga;

clk_wiz u_clk_wiz (
            // Clock out ports
            .clk_out1(clk_vga),     // output clk_out1
            // Status and control signals
            .reset(~rstn), // input reset
            // Clock in ports
            .clk_in1(clk));      // input clk_in1

reg[11:0] control_reg = 12'b111111110000;

/* RGB signals */
reg[3:0] reg_red;
reg[3:0] reg_green;
reg[3:0] reg_blue;

assign red = reg_red;
assign green = reg_green;
assign blue = reg_blue;

/* Horizonal & Vertical refresh pulses */

reg h_reg;
reg v_reg;

assign hs = h_reg;
assign vs = v_reg;

reg[10:0] h_count;
reg[10:0] v_count;

/* horizontal scan and vertical scan */

always @ (posedge clk_vga) begin
    if (rstn == `RST_EN) begin
        h_count <= 11'b0;
        v_count <= 11'b0;
    end
    else begin
        if (h_count == H_TOTAL - 1) begin
            h_count <= 11'b0;
            if (v_count == V_TOTAL - 1) begin
                v_count <= 11'b0;
            end
            else begin
                v_count <= v_count + 1'b1;
            end
        end
        else begin
            h_count <= h_count + 1'b1;
        end
    end
end

always @ (posedge clk_vga) begin
    if (h_count < H_SYNC_PULSE) begin
        h_reg <= 1'b0;
    end
    else begin
        h_reg <= 1'b1;
    end
end

always @ (posedge clk_vga) begin
    if (v_count < V_SYNC_PULSE) begin
        v_reg <= 1'b0;
    end
    else begin
        v_reg <= 1'b1;
    end
end

/* Control RGB */

always @ (posedge clk_vga) begin
    reg_red <= control_reg[11:8];
    reg_green <= control_reg[7:4];
    reg_blue <= control_reg[3:0];
end
endmodule
