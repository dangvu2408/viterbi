`timescale 1ns/1ps

module tb_add_comp;

    reg clk, rst, en_add;
    reg [1:0] hd1, hd2, hd3, hd4, hd5, hd6, hd7, hd8;

    wire [1:0] prv_st_00, prv_st_01, prv_st_10, prv_st_11;
    wire [1:0] sel_node;

    add_comp uut (
        .clk(clk),
        .rst(rst),
        .en_add(en_add),
        .hamd_1(hd1), .hamd_2(hd2), .hamd_3(hd3), .hamd_4(hd4),
        .hamd_5(hd5), .hamd_6(hd6), .hamd_7(hd7), .hamd_8(hd8),

        .prv_st_00(prv_st_00), .prv_st_01(prv_st_01),
        .prv_st_10(prv_st_10), .prv_st_11(prv_st_11),
        .sel_node(sel_node)
    );

    always #5 clk = ~clk;   

    initial begin
        $display("==== Begin Sim ====");

        clk = 0;
        rst = 1;
        en_add = 0;

        hd1 = 0; hd2 = 0; hd3 = 0; hd4 = 0;
        hd5 = 0; hd6 = 0; hd7 = 0; hd8 = 0;

        #10 rst = 0;
        #10 rst = 1;
        #10 rst = 0;

        en_add = 1;

        hd1 = 2; hd2 = 3; hd3 = 1; hd4 = 2;
        hd5 = 2; hd6 = 1; hd7 = 3; hd8 = 0;

        repeat(10) @(posedge clk);

        en_add = 0;

        $display("=== RESULT ===");
        $display("Sum final node = sel_node = %b", sel_node);
        $display("prv_st_00=%b prv_st_01=%b prv_st_10=%b prv_st_11=%b",
                  prv_st_00, prv_st_01, prv_st_10, prv_st_11);

        $stop;
    end


endmodule
