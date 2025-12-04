`timescale 1ns/1ps

module tb_ham_d;

    reg clk, rst, en_brch;
    reg [15:0] data;
    reg done_input;
    reg [15:0] testing_data [0:1023];
    integer index;

    wire [1:0] hamd_1, hamd_2, hamd_3, hamd_4;
    wire [1:0] hamd_5, hamd_6, hamd_7, hamd_8;

    ham_d uut (
        .clk(clk),
        .rst(rst),
        .en_brch(en_brch),
        .data(data),
        .hamd_1(hamd_1), .hamd_2(hamd_2),
        .hamd_3(hamd_3), .hamd_4(hamd_4),
        .hamd_5(hamd_5), .hamd_6(hamd_6),
        .hamd_7(hamd_7), .hamd_8(hamd_8)
    );

    always #5 clk = ~clk;  

    initial begin
        $display("=== Start Simulation ===");

        clk = 0;
        rst = 1;
        en_brch = 0;
        index = 0;
        done_input = 0;

        $readmemb("../input.txt", testing_data);

        #10 rst = 1;
        #10 rst = 0;
        en_brch = 1;

        data     = testing_data[index];
    end

    always @(posedge clk) begin
        if (!rst && en_brch && !done_input) begin
            $display("Time %t | index: %0d | rx: %b | hd1~hd8: %b %b %b %b %b %b %b %b", 
                $time, index, uut.data_rx,
                hamd_1, hamd_2, hamd_3, hamd_4, hamd_5, hamd_6, hamd_7, hamd_8);
        end

        if (!rst && en_brch && !done_input) begin
            index = index + 1;

            if (index < 1026 && testing_data[index] !== 16'bx) begin
                data = testing_data[index];
            end else begin
                done_input = 1;
                en_brch = 0;
                $display("=== Done feeding inputs ===");
                $finish;
            end
        end
    end

endmodule
