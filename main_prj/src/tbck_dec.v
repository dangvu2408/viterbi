module mem (clk, rst, en_tbck, bck_prv_st_00, bck_prv_st_01,
                               bck_prv_st_10, bck_prv_st_11,
                               sel_node, data_out);
    input            clk, rst, en_tbck;
    input      [1:0] bck_prv_st_00, bck_prv_st_01, bck_prv_st_10, bck_prv_st_11;
    input      [1:0] sel_node;
    output reg [7:0] data_out;

    reg [7:0] sel_bit_out;
    reg [3:0] count;
    reg in_bit;

    localparam [1:0] s0 = 2'b00;
    localparam [1:0] s1 = 2'b01;
    localparam [1:0] s2 = 2'b10;
    localparam [1:0] s3 = 2'b11;

    reg [1:0] select_node, next_select_node; 

    always @ (posedge clk or posedge rst) begin 
        if (rst) begin 
            data_out <= 0;
            sel_bit_out <= 8'b00000000;
            count <= 0;
            select_node <= s0;
        end else begin 
            if (en_tbck) begin 
                select_node <= next_select_node;
                count <= count + 1;
            end else begin 
                select_node <= sel_node;
                count <= count;
                sel_bit_out <= 8'b00000000;
            end
        end
    end

    always @ (posedge clk or posedge rst) begin 
        case (select_node)
            s0: begin 
                if (bck_prv_st_00 == 2'b00)
                    next_select_node <= s0;
                else
                    next_select_node <= s1;
                in_bit <= 0;
            end

            s1: begin 
                if (bck_prv_st_01 == 2'b10)
                    next_select_node <= s2;
                else
                    next_select_node <= s3;
                in_bit <= 0;
            end

            s2: begin 
                if (bck_prv_st_10 == 2'b00)
                    next_select_node <= s0;
                else
                    next_select_node <= s1;
                in_bit <= 1;
            end

            s3: begin 
                if (bck_prv_st_11 == 2'b10)
                    next_select_node <= s2;
                else
                    next_select_node <= s3;
                in_bit <= 1;
            end

            sel_bit_out[count] = in_bit;
        endcase
    end

    always @ (posedge clk) begin 
        if (count == 8) begin 
            count <= 0;
            data_out <= sel_bit_out;
        end
    end
endmodule