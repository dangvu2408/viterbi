`timescale 1ns / 1ps

module branch_metric_tb();

    reg clk, rst, en_ext, en_brch;
    reg [15:0] i_data;
    wire [1:0] rx;

    wire [1:0] hd1, hd2, hd3, hd4, hd5, hd6, hd7, hd8;

    reg [15:0] in_data [0:1023];
    integer index;
    reg done_input;
    always #5 clk = ~clk;
    extract_bit u_extract (
        .rst(rst),
        .clk(clk),
        .en_ext(en_ext),
        .i_data(i_data),
        .o_rx(rx)
    );
    branch_metric u_branch (
        .rst(rst),
        .en_brch(en_brch),
        .i_rx(rx),
        .hd1(hd1),
        .hd2(hd2),
        .hd3(hd3),
        .hd4(hd4),
        .hd5(hd5),
        .hd6(hd6),
        .hd7(hd7),
        .hd8(hd8)
    );

    initial begin
        clk = 0;
        rst = 0;
        en_ext = 0;
        en_brch = 0;
        index = 0;
        done_input = 0;

        $readmemb("/mnt/hgfs/VMshare/input.txt", in_data);

        #10 rst = 0;
        #10 rst = 1;

        en_ext = 1;
        en_brch = 1;

        i_data = in_data[index];
    end

    always @(posedge clk) begin
        if (rst && en_ext && !done_input) begin
            $display("Time %t | index: %0d | rx: %b | hd1~hd8: %b %b %b %b %b %b %b %b", 
                $time, index, rx,
                hd1, hd2, hd3, hd4, hd5, hd6, hd7, hd8);
        end

        if (rst && en_ext && u_extract.count < 2 && !done_input) begin
            index = index + 1;

            if (index < 1026 && in_data[index] !== 16'bx) begin
                i_data = in_data[index];
            end else begin
                done_input = 1;
                en_ext = 0;
                en_brch = 0;
                $display("=== Done feeding inputs ===");
                $finish;
            end
        end
    end

endmodule

