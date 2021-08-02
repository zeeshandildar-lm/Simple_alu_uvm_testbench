//`uvm_analysis_imp_decl()
class simplelalu_scoreboard extends uvm_scoreboard;
`uvm_component_utils(simplelalu_scoreboard);

 uvm_analysis_export #(simplealu_transaction) sb_export;

 uvm_tlm_analysis_fifo #(simplealu_transaction) fifo;

 simplealu_transaction transaction;
 bit [3:0] out;

 function new(string name, uvm_component parent);
    super.new(name, parent);
    transaction = new("transaction");
 endfunction: new

 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_export = new("sb_export", this);

    fifo = new("fifo", this);
 endfunction: build_phase

 function void connect_phase(uvm_phase phase);
    sb_export.connect(fifo.analysis_export);
 endfunction: connect_phase

 task run();
    forever begin
        transaction = simplealu_transaction::type_id::create(.name("transaction"), .contxt(get_full_name()));
        fifo.get(transaction);
        sa_predictor();
        compare();
    end
 endtask: run

virtual function void sa_predictor();
        if      (transaction.select_op == 2'b00)  out = transaction.a + transaction.b;
        else if (transaction.select_op == 2'b01)  out = transaction.a & transaction.b;
        else if (transaction.select_op == 2'b10)  out = transaction.a | transaction.b;
        else                                      out = ~(transaction.a + transaction.b);
    endfunction: sa_predictor
 virtual function void compare();
    if(transaction.out == out) begin 
        `uvm_info("compare", {"TEST: OK!"}, UVM_LOW);
    end
    else begin
        `uvm_info("comapre", {"TEST: FAIL!"}, UVM_LOW);
    end
 endfunction: compare
endclass: simplelalu_scoreboard