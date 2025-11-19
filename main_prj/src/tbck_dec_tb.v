`timescale 1ns/1ps

module tb_tbck_dec;

    reg clk, rst, en_tbck;
    reg [1:0] bck_prv_st_00, bck_prv_st_01, bck_prv_st_10, bck_prv_st_11;
    reg [1:0] sel_node;

    wire [7:0] data_out;
    wire done_flag;

    tbck_dec uut (
        .clk(clk),
        .rst(rst),
        .en_tbck(en_tbck),
        .bck_prv_st_00(bck_prv_st_00),
        .bck_prv_st_01(bck_prv_st_01),
        .bck_prv_st_10(bck_prv_st_10),
        .bck_prv_st_11(bck_prv_st_11),
        .sel_node(sel_node),
        .data_out(data_out),
        .done_flag(done_flag)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== START SIM ===");

        clk = 0;
        rst = 1;
        en_tbck = 0;

        bck_prv_st_00 = 2'b01;
        bck_prv_st_01 = 2'b10;
        bck_prv_st_10 = 2'b01;
        bck_prv_st_11 = 2'b11;

        sel_node = 2'b11;   

        #20 rst = 0;        
        #10 en_tbck = 1;    

        wait(done_flag == 1);

        $display("data_out = %b", data_out);

        #20;
        $display("=== END SIM ===");
        $stop;
    end

endmodule
