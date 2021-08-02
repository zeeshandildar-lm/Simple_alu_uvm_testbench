class simplealu_transaction extends uvm_sequence_item;
    rand bit [3:0] a;
    rand bit [3:0] b;
    rand bit en_i;
    rand bit en_o;
    rand bit [1:0] select_op;
         bit [3:0] out;

    function new(string name = "");
        super.new(name);
    endfunction: new

    `uvm_object_utils_begin(simplealu_transaction)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(en_i, UVM_ALL_ON)
    `uvm_field_int(en_o, UVM_ALL_ON)
    `uvm_field_int(select_op, UVM_ALL_ON)
    `uvm_object_utils_end
endclass: simplealu_transaction

class simplealu_sequence extends uvm_sequence#(simplealu_transaction);
    `uvm_object_utils(simplealu_sequence)

    function new(string name = "");
        super.new(name);
    endfunction: new    
    
    task body();
        simplealu_transaction sa_tx;
        repeat(15) begin
            sa_tx = simplealu_transaction::type_id::create(.name("sa_tx"), .contxt(get_full_name()));
            start_item(sa_tx);
                assert(sa_tx.randomize());
            finish_item(sa_tx);
        end
    endtask: body
endclass: simplealu_sequence

typedef uvm_sequencer#(simplealu_transaction) simplealu_sequencer;