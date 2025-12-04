module ctrl (clk, rst, en, en_brch, en_add, en_mem, en_tbck);
    input      clk, rst, en;
    output reg en_brch, en_add, en_mem, en_tbck;
    reg [2:0]  state, next_state;
    reg [3:0]  count;

    localparam [2:0] s0 = 3'b000; // reset 
    localparam [2:0] s1 = 3'b001; // extract and ham_d
    localparam [2:0] s2 = 3'b010; // add-comp
    localparam [2:0] s3 = 3'b011; // memory
    localparam [2:0] s4 = 3'b100; // traceback

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            state <= s0;
        end else begin
            if (en == 1) begin
                count <= count + 1; 
                state <= next_state;
            end else begin
                count <= count;
                state <= state; 
            end
        end
    end

    always @ (posedge rst or state or count or en or posedge clk) begin
        case(state)
            s0: begin
                en_brch = 0; en_add = 0; en_mem = 0; en_tbck = 0;
                if (en == 1)
                    next_state = s1;
                else
                    next_state = state;
            end
        
            s1: begin
                en_brch = 1; en_add = 0; en_mem = 0; en_tbck = 0;
                next_state = s2;
            end
        
            s2: begin
                en_brch = 1; en_add = 1; en_mem = 0; en_tbck = 0;
                next_state = s3;
            end
        
            s3: begin
                en_brch = 1; en_add = 1; en_mem = 1; en_tbck = 0;
                if(count < 11)
                    next_state = s3;
                else 
                    next_state = s4;
            end
        
            s4: begin
                en_brch = 0; en_add = 0; en_mem = 1; en_tbck = 1;
                next_state = s4;
            end
        endcase
    end
endmodule