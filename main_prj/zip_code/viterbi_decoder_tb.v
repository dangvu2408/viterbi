`timescale 1ns / 1ps

module viterbi_decoder_tb();
    reg clk, rst, en;
    reg [15:0] data;
    wire [7:0] data_out;
    wire done_flag;

    reg [5:0] count;
    integer index;
    integer file_outputs;
    reg [15:0] in_ram [0:1024];

    viterbi_decoder vd1 (
        .clk(clk),
        .rst(rst),
        .en(en),
        .data(data),
        .data_out(data_out),
        .done_flag(done_flag)
    );

    always #5 clk = ~clk; 
    initial  begin
        // Initialize signal
        clk = 0;
        rst = 0;
        en = 1;
        
        // Reset
        #10 rst = 1;
        #1 rst = 0;
    end


    initial begin 
        index <= 1;
        $readmemb("input.txt", in_ram);
        file_outputs = $fopen("output_result.txt", "w");
        data <= in_ram[0];

    end

    always @ (posedge done_flag) begin
        $display("Output data from input line %d is: %b\n", index, data_out);
        $fwrite(file_outputs, "%b\n", data_out);
        #10;
        index <= index + 1;
        data <= in_ram[index];
        rst = 1;
        #1 rst = 0;

        if(index >= 1026) begin
            $fclose(file_outputs);
            $finish;
        end
    end

endmodule
