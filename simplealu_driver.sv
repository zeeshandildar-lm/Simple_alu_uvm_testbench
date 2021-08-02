class simplealu_driver extends uvm_driver#(simplealu_transaction);
    `uvm_component_utils(simplealu_driver)

    virtual simplealu_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        void'(uvm_resource_db#(virtual simplealu_if)::read_by_name(.scope("ifs"), .name("simplealu_if"), .val(vif)));
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        simplealu_transaction sa_tx;

        forever begin
            seq_item_port.get_next_item(sa_tx);
            vif.a = sa_tx.a;
            vif.b = sa_tx.b;
            vif.select_op = sa_tx.select_op;
            vif.en_i = sa_tx.en_i;
            seq_item_port.item_done();
        end
    endtask: run_phase
endclass: simplealu_driver
