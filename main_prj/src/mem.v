module mem (clk, rst, en_mem, prv_st_00, prv_st_01, 
                              prv_st_10, prv_st_11, 
                              bck_prv_st_00, bck_prv_st_01,
                              bck_prv_st_10, bck_prv_st_11);
    input            clk, rst, en_mem;
    input            prv_st_00, prv_st_01, prv_st_10, prv_st_11; 
    output reg [1:0] bck_prv_st_00, bck_prv_st_01, bck_prv_st_10, bck_prv_st_11;

    reg [3:0] count; 
    reg [1:0] trellis_diagr[0:3][0:7];
    reg [2:0] trace; 

    integer i;
    integer k;

    always @ (posedge clk or posedge rst) begin 
        if (rst) begin 
            count <= 0; 
            trace <= 7;
            for (i = 0; i < 4; i = i + 1) begin         // 4 x 8 = 32 elements
                for (k = 0; k < 8; k = k + 1) begin
                    trellis_diagr[i][k] <= 2'b00;       // return to node 00
                end
            end
        end else begin 
            if (en_mem) begin 
                if (count < 8) begin 
                    trellis_diagr[0][count] <= prv_st_00; 
                    trellis_diagr[2][count] <= prv_st_10; 
                    trellis_diagr[1][count] <= prv_st_01;
                    trellis_diagr[3][count] <= prv_st_11;
                    count <= count + 1;
                end

                if (count == 8) begin 
                    bck_prv_st_00 <= trellis_diagr[0][trace]; 
                    bck_prv_st_10 <= trellis_diagr[2][trace]; 
                    bck_prv_st_01 <= trellis_diagr[1][trace];
                    bck_prv_st_11 <= trellis_diagr[3][trace];
                    if (trace != 0) 
                        trace <= trace - 1;
                end
            end
        end
    end
endmodule