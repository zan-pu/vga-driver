`timescale 1ns / 1ps
`include "params.vh"

/*
 * Module: VGA top module
 */

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

           // input wire       wen,
           // input wire[31:0] wdata,
           // input wire[3:0]  addr,
           // input wire       rdata,

           output wire      hs,
           output wire      vs,
           output wire[3:0] red,
           output wire[3:0] green,
           output wire[3:0] blue
       );


/* --- Standalone version variables --- */
wire       wen;
wire[31:0] wdata;
wire[3:0]  addr;
wire       rdata;

/* --- VGA data memory --- */
reg[31:0] data[15:0];

assign rdata = data[addr];
reg[3:0] p_x;
reg[3:0] p_y;
reg[31:0] player_x;

/* --- Initialize map --- */

always @ (posedge clk_vga) begin
    if (rstn == `RST_EN) begin
        data[0]  <= 32'h00000000;
        data[1]  <= 32'h15545518;
        data[2]  <= 32'h10040110;
        data[3]  <= 32'h11555510;
        data[4]  <= 32'h11100010;
        data[5]  <= 32'h11155554;
        data[6]  <= 32'h11000000;
        data[7]  <= 32'h11555454;
        data[8]  <= 32'h10000444;
        data[9]  <= 32'h15554444;
        data[10] <= 32'h01000444;
        data[11] <= 32'h15555444;
        data[12] <= 32'h10010044;
        data[13] <= 32'h15515554;
        data[14] <= 32'h30100000;
        data[15] <= 32'h00000000;
        p_x <= 4'b0000;
        p_y <= 4'b0000;
        player_x <= 32'h00000000;
    end
end

/* --- Write data to VGA Driver memory --- */

always @ (posedge clk)  begin
    if (wen) begin
        data[addr] <= wdata;
    end
end

/* --- VGA Driver --- */

// 65 MHz clock signal

wire clk_vga;

clk_wiz u_clk_wiz (
            // Clock out ports
            .clk_out1(clk_vga),     // output clk_out1
            // Status and control signals
            .reset(~rstn), // input reset
            // Clock in ports
            .clk_in1(clk));      // input clk_in1

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

/* --- Render Map --- */

always @ (posedge clk_vga) begin
    player_x <= data[addr];
    p_x <= addr;
    if (player_x[29:28] == 2'b11) begin
        p_y <= 4'b1111;
    end
    else if(player_x[27:26] == 2'b11) begin
        p_y <= 4'b1110;
    end
    else if(player_x[25:24] == 2'b11) begin
        p_y <= 4'b1101;
    end
    else if(player_x[23:22] == 2'b11) begin
        p_y <= 4'b1100;
    end
    else if(player_x[21:20] == 2'b11) begin
        p_y <= 4'b1011;
    end
    else if(player_x[19:18] == 2'b11) begin
        p_y <= 4'b1010;
    end
    else if(player_x[17:16] == 2'b11) begin
        p_y <= 4'b1001;
    end
    else if(player_x[15:14] == 2'b11) begin
        p_y <= 4'b1000;
    end
    else if(player_x[13:12] == 2'b11) begin
        p_y <= 4'b0111;
    end
    else if(player_x[11:10] == 2'b11) begin
        p_y <= 4'b0110;
    end
    else if(player_x[9:8] == 2'b11) begin
        p_y <= 4'b0101;
    end
    else if(player_x[7:6] == 2'b11) begin
        p_y <= 4'b0100;
    end
    else if(player_x[5:4] == 2'b11) begin
        p_y <= 4'b0011;
    end
    else if(player_x[3:2] == 2'b11) begin
        p_y <= 4'b0010;
    end
    else begin
        p_y <= 4'b0000;
    end
end

/* --- Control RGB --- */

reg[1:0] debug;

always @ (posedge clk_vga) begin
    /* Game board */
    if (h_count < 1140 && h_count > 500 && v_count < 740 && v_count > 100) begin
        if(h_count>p_x*40+460 && h_count<p_x*40+500&&v_count>740-p_y*40 && v_count<780-p_y*40 && v_count!=0) begin
            reg_red   <= `RED_R;
            reg_green <= `RED_G;
            reg_blue  <= `RED_B;
        end
        else if(h_count>500 && h_count<540) begin
            reg_red   <= `BLACK_R;
            reg_green <= `BLACK_G;
            reg_blue  <= `BLACK_B;
        end
        else if(h_count>540 && h_count<580) begin
            if((v_count>100&&v_count<140) || (v_count>380&&v_count<420) || (v_count>580 && v_count<620) || (v_count>700 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
            else if (v_count>660 &&v_count<700) begin
                reg_red   <= `GREEN_R;
                reg_green <= `GREEN_G;
                reg_blue  <= `GREEN_B;
            end
        end
        else if(h_count>580 && h_count<620) begin
            if((v_count>100&&v_count<140) || (v_count>180&&v_count<340) || (v_count>380 && v_count<540) || (v_count>580 && v_count<620) || (v_count>660 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>620 && h_count<660) begin
            if((v_count>100&&v_count<140) || (v_count>180&&v_count<220) || (v_count>580 && v_count<620) || (v_count>660 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>660 && h_count<700) begin
            if((v_count>100&&v_count<140) || (v_count>180&&v_count<220) || (v_count>260 && v_count<300) || (v_count>340 && v_count<620) || (v_count>660 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>700 && h_count<740) begin
            if((v_count>100&&v_count<140) || (v_count>180&&v_count<220) || (v_count>260 && v_count<300) || (v_count>700 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>740 && h_count<780) begin
            if((v_count>100&&v_count<140) || (v_count>180&&v_count<220) || (v_count>260 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>780 && h_count<820) begin
            if((v_count>100&&v_count<140) || (v_count>180&&v_count<220) || (v_count>540 && v_count<580) || (v_count>700 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>820 && h_count<860) begin
            if((v_count>100&&v_count<140) || (v_count>180&&v_count<500) || (v_count>540 && v_count<580) || (v_count>620 && v_count<660) || (v_count>700 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>860 && h_count<900) begin
            if((v_count>100&&v_count<140) || (v_count>460&&v_count<500) || (v_count>540 && v_count<580) || (v_count>620 && v_count<660) || (v_count>700 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>900 && h_count<940) begin
            if((v_count>100&&v_count<220) || (v_count>260&&v_count<500) || (v_count>540 && v_count<580) || (v_count>620 && v_count<660) || (v_count>700 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>940 && h_count<980) begin
            if((v_count>100&&v_count<140) || (v_count>540 && v_count<580) || (v_count>620 && v_count<660) || (v_count>700 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>980 && h_count<1020) begin
            if((v_count>100&&v_count<140) || (v_count>180&&v_count<380) || (v_count>420 && v_count<580) || (v_count>620 && v_count<660) || (v_count>700 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>1020 && h_count<1060) begin
            if((v_count>100&&v_count<140) || (v_count>340&&v_count<380) || (v_count>700 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>1060 && h_count<1100) begin
            if((v_count>100&&v_count<140) || (v_count>180&&v_count<300) || (v_count>340 && v_count<740)) begin
                reg_red   <= `BLACK_R;
                reg_green <= `BLACK_G;
                reg_blue  <= `BLACK_B;
            end
        end
        else if(h_count>1100 && h_count<1140) begin
            reg_red   <= `BLACK_R;
            reg_green <= `BLACK_G;
            reg_blue  <= `BLACK_B;
        end
        else begin
            reg_red   <= `WHITE_R;
            reg_green <= `WHITE_G;
            reg_blue  <= `WHITE_B;
        end
    end

    /* Out of bounds */
    else begin
        reg_red   <= `RED_R;
        reg_green <= `RED_G;
        reg_blue  <= `RED_B;
    end
end
endmodule
