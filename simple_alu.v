module simple_alu(
    input wire        clk,
    input wire        en_i,
    input wire        en_o,
    input wire [1:0] select_op,
    input wire [3:0] a,
    input wire [3:0] b,

    output reg [3:0] out );

    localparam [1:0]
        ADD  = 2'b00,
        AND  = 2'b01,
        OR   = 2'b10,
        NAND = 2'b11;

        //input registers
    reg [3:0] in_a=0; 
    reg [3:0] in_b=0;

    reg [3:0] temp;

//sample the inputs when en_i is asserted
    always@(posedge clk)
        begin
            if (en_i) 
                begin
                    in_a <= a;
                    in_b <= b;
                end
            else 
                begin
                    in_a <= in_a;
                    in_b <= in_b;
                end

            if (en_o) 
                begin
                    out <= temp;
                end
            else 
                begin
                    out <='0;
                end
    end
// ALU
    always@(*)
        begin
            case(select_op)
                ADD:  temp = in_a + in_b;
                AND:  temp = in_a & in_b;
                OR:   temp = in_a | in_b;
                NAND: temp = ~(in_a & in_b); 
            endcase
    end

endmodule