class simplealu_monitor extends uvm_monitor;
    `uvm_component_utils(simplealu_monitor)
    uvm_analysis_port#(simplealu_transaction) mon_ap;

    virtual simplealu_if vif;

       function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        void'(uvm_resource_db#(virtual simplealu_if)::read_by_name ( .scope("ifs"), .name("simplealu_if"), .val(vif)));
        mon_ap = new(.name("mon_ap_after"), .parent(this));
        endfunction: build_phase

    task run_phase(uvm_phase phase);
        simplealu_transaction sa_tx;
        sa_tx = simplealu_transaction::type_id::create(.name("sa_tx"), .contxt(get_full_name()));
        forever begin
            @(posedge vif.clk)
            if(vif.en_o == 1'b1) begin
                sa_tx.out = vif.out;
            end
            if(vif.en_i == 1'b1) begin
                sa_tx.a = vif.a;
                sa_tx.b = vif.b;
                sa_tx.select_op = vif.select_op;
            end
            mon_ap.write(sa_tx);
        end
    endtask: run_phase
 
endclass: simplealu_monitor