module viterbi_decoder(clk, rst, en, data, data_out, done_flag);
    input clk, rst, en;
    input [15:0] data;

    output [7:0] data_out;
    output done_flag;

    wire en_brch ,en_add, en_mem, en_tbck;
    wire [1:0] hamd_1, hamd_2, hamd_3, hamd_4, hamd_5, hamd_6, hamd_7, hamd_8;
    wire [1:0] prv_st_00, prv_st_01, prv_st_10, prv_st_11;
    wire [1:0] bck_prv_st_00, bck_prv_st_01, bck_prv_st_10, bck_prv_st_11;
    wire [1:0] sel_node;

    ctrl c1 (.clk(clk),
            .rst(rst),
            .en(en),
            .en_brch(en_brch),
            .en_add(en_add),
            .en_mem(en_mem),
            .en_tbck(en_tbck));

    ham_d br1 (.clk(clk),
            .rst(rst),
            .en_brch(en_brch),
            .data(data),
            .hamd_1(hamd_1),
            .hamd_2(hamd_2),
            .hamd_3(hamd_3),
            .hamd_4(hamd_4),
            .hamd_5(hamd_5),
            .hamd_6(hamd_6),
            .hamd_7(hamd_7),
            .hamd_8(hamd_8));

    add_comp add1 (.clk(clk),
            .rst(rst),
            .en_add(en_add),
            .hamd_1(hamd_1),
            .hamd_2(hamd_2),
            .hamd_3(hamd_3),
            .hamd_4(hamd_4),
            .hamd_5(hamd_5),
            .hamd_6(hamd_6),
            .hamd_7(hamd_7),
            .hamd_8(hamd_8),
            .prv_st_00(prv_st_00),
            .prv_st_10(prv_st_10),
            .prv_st_01(prv_st_01),
            .prv_st_11(prv_st_11),
            .sel_node(sel_node));

    mem mem1 (.clk(clk),
            .rst(rst),
            .en_mem(en_mem),
            .prv_st_00(prv_st_00),
            .prv_st_01(prv_st_01),
            .prv_st_10(prv_st_10),
            .prv_st_11(prv_st_11),
            .bck_prv_st_00(bck_prv_st_00),
            .bck_prv_st_01(bck_prv_st_01),
            .bck_prv_st_10(bck_prv_st_10),
            .bck_prv_st_11(bck_prv_st_11));

    tbck_dec tbck1 (.clk(clk),
            .rst(rst),
            .en_tbck(en_tbck),
            .bck_prv_st_00(bck_prv_st_00),
            .bck_prv_st_01(bck_prv_st_01),
            .bck_prv_st_10(bck_prv_st_10),
            .bck_prv_st_11(bck_prv_st_11),
            .sel_node(sel_node),
            .data_out(data_out),
            .done_flag(done_flag));
endmodule