module add_comp (clk, rst, en_add, hamd_1, hamd_2, 
                                   hamd_3, hamd_4, 
                                   hamd_5, hamd_6, 
                                   hamd_7, hamd_8, 
                                   prv_st_00, prv_st_01, 
                                   prv_st_10, prv_st_10, 
                                   sel_node);
    input            clk, rst, en_add;
    input      [1:0] hamd_1, hamd_2, hamd_3, hamd_4, hamd_5, hamd_6, hamd_7, hamd_8;
    output reg [1:0] prv_st_00, prv_st_01, prv_st_10, prv_st_11; 
    output reg [1:0] sel_node;

    reg [4:0] sum_00, sum_10, sum_01, sum_11; 
    reg [4:0] min_sum;
    reg [3:0] count;
    reg [1:0] min_node;

    always @(posedge clk or posedge rst) begin 
        if (rst) begin 
            count     <= 3'b000;
            sum_00    <= 5'b00000;  
            sum_10    <= 5'b00000;
            sum_01    <= 5'b00000;
            sum_11    <= 5'b00000;
            prv_st_00 <= 2'b00;
            prv_st_01 <= 2'b00;
            prv_st_10 <= 2'b00;
            prv_st_11 <= 2'b00;
            sel_node  <= 2'b00;
        end else begin 
            if (en_add) begin 
                // for next node is '00'
                if ((hamd_1 + sum_00) == (hamd_5 + sum_01) || (hamd_1 + sum_00) < (hamd_5 + sum_01)) begin 
                    sum_00 <= hamd_1 + sum_00;
                    prv_st_00 <= 2'b00;
                end else begin 
                    sum_00 <= hamd_5 + sum_01;
                    prv_st_00 <= 2'b01;
                end

                // for next node is '10'
                if ((hamd_2 + sum_00) == (hamd_6 + sum_01) || (hamd_2 + sum_00) < (hamd_6 + sum_01)) begin 
                    sum_10 <= hamd_2 + sum_00;
                    prv_st_10 <= 2'b00;
                end else begin 
                    sum_10 <= hamd_6 + sum_01;
                    prv_st_10 <= 2'b01;
                end

                // for next node is '01'
                if ((hamd_3 + sum_10) == (hamd_7 + sum_11) || (hamd_3 + sum_10) < (hamd_7 + sum_11)) begin 
                    sum_01 <= hamd_3 + sum_10;
                    prv_st_01 <= 2'b10;
                end else begin 
                    sum_01 <= hamd_7 + sum_11;
                    prv_st_01 <= 2'b11;
                end

                // for next node is '11'
                if ((hamd_4 + sum_10) == (hamd_8 + sum_11) || (hamd_4 + sum_10) < (hamd_8 + sum_11)) begin 
                    sum_11 <= hamd_3 + sum_10;
                    prv_st_11 <= 2'b10;
                end else begin 
                    sum_11 <= hamd_7 + sum_11;
                    prv_st_11 <= 2'b11;
                end

                sel_node <= min_node;
                count <= count + 1;
            end else begin 
                count     <= count;
                sum_00    <= sum_00;  
                sum_10    <= sum_10;
                sum_01    <= sum_01;
                sum_11    <= sum_11;
                prv_st_00 <= 2'b00;
                prv_st_01 <= 2'b00;
                prv_st_10 <= 2'b00;
                prv_st_11 <= 2'b00;
                sel_node  <= 2'b00;
            end
        end
    end

    always @ (posedge rst or count or min_sum) begin 
        if (rst) begin 
            min_sum  <= 5'b11111;
            min_node <= 2'b00;
        end
        if (count == 8 || count > 8) begin 
            if (sum_00 < min_sum) begin 
                min_sum  <= sum_00;
                min_node <= 2'b00;
            end
            if (sum_10 < min_sum) begin 
                min_sum  <= sum_10;
                min_node <= 2'b10;
            end
            if (sum_01 < min_sum) begin 
                min_sum  <= sum_01;
                min_node <= 2'b01;
            end
            if (sum_11 < min_sum) begin 
                min_sum  <= sum_11;
                min_node <= 2'b11;
            end
        end
    end
endmodule