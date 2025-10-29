`timescale 1ns / 1ps

module add_comp_slt_tb;

    // Inputs
    reg clk, rst, en_acs;
    reg [1:0] hd1, hd2, hd3, hd4, hd5, hd6, hd7, hd8;

    // Outputs
    wire [1:0] o_prev_st_00, o_prev_st_10, o_prev_st_01, o_prev_st_11;
    wire [1:0] o_slt_node;

    add_comp_slt uut (
        .clk(clk),
        .rst(rst),
        .en_acs(en_acs),
        .hd1(hd1), .hd2(hd2), .hd3(hd3), .hd4(hd4),
        .hd5(hd5), .hd6(hd6), .hd7(hd7), .hd8(hd8),
        .o_prev_st_00(o_prev_st_00),
        .o_prev_st_10(o_prev_st_10),
        .o_prev_st_01(o_prev_st_01),
        .o_prev_st_11(o_prev_st_11),
        .o_slt_node(o_slt_node)
    );

    always #5 clk = ~clk;

    initial begin
        
        clk = 0;
        rst = 0;
        en_acs = 0;
        hd1 = 0; hd2 = 0; hd3 = 0; hd4 = 0;
        hd5 = 0; hd6 = 0; hd7 = 0; hd8 = 0;


        #10 rst = 1;
        #10 rst = 0;
        #10 rst = 1;


        en_acs = 1;


        hd1 = 2; hd2 = 3; hd3 = 1; hd4 = 2;
        hd5 = 2; hd6 = 1; hd7 = 3; hd8 = 0;


        repeat(10) @(posedge clk);


        en_acs = 0;


        $display("=== Kết quả ===");
        $display("o_prev_st_00: %b", o_prev_st_00);
        $display("o_prev_st_10: %b", o_prev_st_10);
        $display("o_prev_st_01: %b", o_prev_st_01);
        $display("o_prev_st_11: %b", o_prev_st_11);
        $display("o_slt_node   : %b", o_slt_node);

        $finish;
    end

endmodule

