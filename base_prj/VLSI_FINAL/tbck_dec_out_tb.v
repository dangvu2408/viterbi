`timescale 1ns/1ps

module tb_traceback;

    reg clk;
    reg rst;
    reg en_trbk;
    reg [1:0] i_slt_node;

    reg [1:0] i_bck_prev_st_00;
    reg [1:0] i_bck_prev_st_10;
    reg [1:0] i_bck_prev_st_01;
    reg [1:0] i_bck_prev_st_11;

    wire [7:0] o_data;
    wire o_done;

    // DUT (Device Under Test)
    traceback dut (
        .clk(clk),
        .rst(rst),
        .en_trbk(en_trbk),
        .i_slt_node(i_slt_node),
        .i_bck_prev_st_00(i_bck_prev_st_00),
        .i_bck_prev_st_10(i_bck_prev_st_10),
        .i_bck_prev_st_01(i_bck_prev_st_01),
        .i_bck_prev_st_11(i_bck_prev_st_11),
        .o_data(o_data),
        .o_done(o_done)
    );

    // Clock 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // initialize
        rst = 0;
        en_trbk = 0;
        i_slt_node = 2'b00;

        i_bck_prev_st_00 = 2'b00;
        i_bck_prev_st_10 = 2'b00;
        i_bck_prev_st_01 = 2'b10;
        i_bck_prev_st_11 = 2'b10;

        #20;
        rst = 1;
        
        // Viterbi traceback bắt đầu từ node ban đầu
        i_slt_node = 2'b00;

        #20;
        en_trbk = 1;      // bắt đầu quá trình traceback


        #200;

        en_trbk = 0;        // stop
        #20;

        $finish;
    end

    // In log để debug
    initial begin
        $monitor("t=%0dns | sel_node_start=%b | o_done=%b | o_data=%b",
                  $time, i_slt_node, o_done, o_data);
    end

endmodule
