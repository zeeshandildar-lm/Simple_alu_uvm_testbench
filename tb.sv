`include "simple_alu.v"
module tb_alu();

    logic clk;
    logic en_i;
    logic en_o;
    logic [1:0] select_op;
    logic [3:0] a;
    logic [3:0] b;

    logic [3:0] out;


    simple_alu DUT (
    	.clk       (clk       ),
        .en_i      (en_i      ),
        .en_o      (en_o      ),
        .select_op (select_op ),
        .a         (a         ),
        .b         (b         ),
        .out       (out       )
    );
    
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        $dumpvars();
        $dumpfile("alu_wave.vcd");
    end

    initial begin
        en_i        = '0;
        en_o        = '0;
        select_op   = '0;
        a           = '0;
        b           = '0;
        repeat(5)@(posedge clk);
        en_i        = 1'b0;
        en_o        = '0;
        select_op   = 2'b00;
        a           = 4'b0001;
        b           = 4'b0011;
        @(posedge clk);

        en_i        = 1'b1;
        en_o        = '0;
        select_op   = 2'b00;
        a           = 4'b0001;
        b           = 4'b0011;
        @(posedge clk);

        en_i        = 1'b0;
        en_o        = 1'b1;
        select_op   = 2'b00;
        a           = 4'b0011;
        b           = 4'b0010;
        @(posedge clk);


        en_i        = 1'b1;
        en_o        = 1'b1;
        select_op   = 2'b01;
        a           = 4'b0011;
        b           = 4'b0010;
        @(posedge clk);

        en_i        = 1'b1;
        en_o        = 1'b1;
        select_op   = 2'b10;
        a           = 4'b0011;
        b           = 4'b0011;
        @(posedge clk);
        repeat(50)@(posedge clk);
        $finish;

    end
endmodule