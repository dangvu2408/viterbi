module ham_d (clk, rst, en_brch, data, hamd_1, hamd_2, 
                                       hamd_3, hamd_4, 
                                       hamd_5, hamd_6, 
                                       hamd_7, hamd_8);
    input        clk, rst, en_brch;
    input  [15:0] data;
    output [1:0]  hamd_1, hamd_2, hamd_3, hamd_4, hamd_5, hamd_6, hamd_7, hamd_8;

    reg [3:0]    count;        // counter for extract bit from MSB to LSB
    reg [1:0]    data_rx;      // data after extract (2 bit)
    reg [15:0]   data_reg;     // data register

    always @(posedge clk or posedge rst) begin 
        if (rst) begin 
            count    <= 4'b1111;
            data_rx  <= 2'b00;
            data_reg <= 16'b0;

            hamd_1   <= 2'b00;
            hamd_2   <= 2'b00;
            hamd_3   <= 2'b00;
            hamd_4   <= 2'b00;
            hamd_5   <= 2'b00;
            hamd_6   <= 2'b00;
            hamd_7   <= 2'b00;
            hamd_8   <= 2'b00;
        end else begin 
            data_reg <= data;
            if (en_brch) begin 
                data_rx <= {data_reg[count], data_reg[count - 1]};
                count <= count - 2;

                case (data_rx) 
                    2'b00: begin
                        hamd_1 <= 2'd0; hamd_2 <= 2'd2; hamd_3 <= 2'd1; hamd_4 <= 2'd1;
                        hamd_5 <= 2'd2; hamd_6 <= 2'd0; hamd_7 <= 2'd1; hamd_8 <= 2'd1;
                    end

                    2'b01: begin
                        hamd_1 <= 2'd1; hamd_2 <= 2'd1; hamd_3 <= 2'd2; hamd_4 <= 2'd0;
                        hamd_5 <= 2'd1; hamd_6 <= 2'd1; hamd_7 <= 2'd0; hamd_8 <= 2'd2;
                    end

                    2'b10: begin
                        hamd_1 <= 2'd1; hamd_2 <= 2'd1; hamd_3 <= 2'd0; hamd_4 <= 2'd2;
                        hamd_5 <= 2'd1; hamd_6 <= 2'd1; hamd_7 <= 2'd2; hamd_8 <= 2'd0;
                    end

                    2'b11: begin
                        hamd_1 <= 2'd2; hamd_2 <= 2'd0; hamd_3 <= 2'd1; hamd_4 <= 2'd1;
                        hamd_5 <= 2'd0; hamd_6 <= 2'd2; hamd_7 <= 2'd1; hamd_8 <= 2'd1;
                    end

                    default: begin
                        hamd_1 <= 0; hamd_2 <= 0; hamd_3 <= 0; hamd_4 <= 0;
                        hamd_5 <= 0; hamd_6 <= 0; hamd_7 <= 0; hamd_8 <= 0;
                    end
                endcase
            end else begin 
                data_rx <= 2'b00;
                count   <= count;
                hamd_1 <= 0; hamd_2 <= 0; hamd_3 <= 0; hamd_4 <= 0;
                hamd_5 <= 0; hamd_6 <= 0; hamd_7 <= 0; hamd_8 <= 0;
            end
        end
    end
endmodule