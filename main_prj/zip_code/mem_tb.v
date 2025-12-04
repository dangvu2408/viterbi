`timescale 1ns/1ps

module tb_mem;

    reg clk, rst, en_mem;
    reg [1:0] prv_st_00, prv_st_01, prv_st_10, prv_st_11;

    wire [1:0] bck_prv_st_00;
    wire [1:0] bck_prv_st_01;
    wire [1:0] bck_prv_st_10;
    wire [1:0] bck_prv_st_11;

    mem uut (
        .clk(clk),
        .rst(rst),
        .en_mem(en_mem),
        .prv_st_00(prv_st_00),
        .prv_st_01(prv_st_01),
        .prv_st_10(prv_st_10),
        .prv_st_11(prv_st_11),
        .bck_prv_st_00(bck_prv_st_00),
        .bck_prv_st_01(bck_prv_st_01),
        .bck_prv_st_10(bck_prv_st_10),
        .bck_prv_st_11(bck_prv_st_11)
    );

    always #5 clk = ~clk;

    initial begin
        $display("===== START SIM =====");

        clk = 0;
        rst = 1;
        en_mem = 0;

        prv_st_00 = 2'b00;
        prv_st_01 = 2'b00;
        prv_st_10 = 2'b00;
        prv_st_11 = 2'b00;

        #20 rst = 0;
        en_mem = 1;

        prv_st_00 = 2'b01;
        prv_st_01 = 2'b10;
        prv_st_10 = 2'b01;
        prv_st_11 = 2'b11;

        repeat(8) @(posedge clk);

        repeat(10) @(posedge clk);

        en_mem = 0;

        $display("===== END SIM =====");
        $stop;
    end

    initial begin
        $monitor("t=%0t | bck00=%b bck01=%b bck10=%b bck11=%b",
                  $time,
                  bck_prv_st_00,
                  bck_prv_st_01,
                  bck_prv_st_10,
                  bck_prv_st_11);
    end

endmodule
