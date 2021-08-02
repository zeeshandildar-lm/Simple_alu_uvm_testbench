interface simplealu_if;
    logic        clk;
    logic        en_i;
    logic        en_o;
    logic  [1:0] select_op;
    logic  [3:0] a;
    logic  [3:0] b;

    logic  [3:0] out;
endinterface
