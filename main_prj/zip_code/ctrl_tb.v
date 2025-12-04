`timescale 1ns/1ps

module ctrl_tb();

    reg clk, rst, en;
    wire en_brch, en_add, en_mem, en_tbck;

    ctrl uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .en_brch(en_brch),
        .en_add(en_add),
        .en_mem(en_mem),
        .en_tbck(en_tbck)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        en  = 0;

        #20 rst = 0;

        #10 en = 1;	

        #300;

        en = 0;

        #50 $finish;
    end

endmodule
