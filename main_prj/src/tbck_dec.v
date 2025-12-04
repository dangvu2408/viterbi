module tbck_dec (clk, rst, en_tbck, bck_prv_st_00, bck_prv_st_01,
                               bck_prv_st_10, bck_prv_st_11,
                               sel_node, data_out, done_flag);
    input            clk, rst, en_tbck;
    input      [1:0] bck_prv_st_00, bck_prv_st_01, bck_prv_st_10, bck_prv_st_11;
    input      [1:0] sel_node;
    output reg [7:0] data_out;
    output reg       done_flag;

    reg [7:0] sel_bit_out;
    reg [3:0] count;
    reg in_bit;

    localparam [1:0] s0 = 2'b00;
    localparam [1:0] s1 = 2'b01;
    localparam [1:0] s2 = 2'b10;
    localparam [1:0] s3 = 2'b11;

    reg [1:0] select_node, next_select_node; 

	always @(posedge clk or posedge rst) begin
        if (rst) begin
            select_node <= s0;
            count       <= 0;
            sel_bit_out <= 8'b0;
            in_bit      <= 0;
            data_out    <= 8'b0;
            done_flag   <= 0;
        end else if (en_tbck) begin
            // FSM Traceback
            case (select_node)
                s0: begin
                    in_bit <= 0;
                    if (bck_prv_st_00 == 2'b00)
                        select_node <= s0;
                    else
                        select_node <= s1;
                end
                s1: begin
                    in_bit <= 0;
                    if (bck_prv_st_01 == 2'b10)
                        select_node <= s2;
                    else
                        select_node <= s3;
                end
                s2: begin
                    in_bit <= 1;
                    if (bck_prv_st_10 == 2'b00)
                        select_node <= s0;
                    else
                        select_node <= s1;
                end
                s3: begin
                    in_bit <= 1;
                    if (bck_prv_st_11 == 2'b10)
                        select_node <= s2;
                    else
                        select_node <= s3;
                end
            endcase

            // Ghi bit vào sel_bit_out
            sel_bit_out[count] <= in_bit;

            // Tăng count
            if (count < 8)
                count <= count + 1;
            else begin
                count     <= 0;
                data_out  <= sel_bit_out;
                done_flag <= 1;
            end
        end
    end
endmodule