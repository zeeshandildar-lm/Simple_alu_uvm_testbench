class simplealu_monitor extends uvm_monitor;
    `uvm_component_utils(simplealu_monitor)
    uvm_analysis_port#(simplealu_transaction) mon_ap;

    virtual simplealu_if vif;

       function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if( !uvm_config_db#(virtual simplealu_if)::get(this,"*", "simplealu_vif", vif))
         `uvm_fatal(get_full_name(),{"virtual interface must be set for:",".simplealu_vif"}); //get method

        mon_ap = new(.name("mon_ap"), .parent(this));
        endfunction: build_phase

    task run_phase(uvm_phase phase);
        simplealu_transaction sa_tx;
        sa_tx = simplealu_transaction::type_id::create(.name("sa_tx"), .contxt(get_full_name()));
        forever begin
            @(posedge vif.clk)
            if(vif.en_i == 1'b1) begin
                sa_tx.a = vif.a;
                sa_tx.b = vif.b;
                sa_tx.select_op = vif.select_op;
            end
            if(vif.en_o == 1'b1) begin
                sa_tx.out = vif.out;
                mon_ap.write(sa_tx);
            end
            
           // mon_ap.write(sa_tx);
        end
    endtask: run_phase
 
endclass: simplealu_monitor