class simplealu_agent extends uvm_agent;
`uvm_component_utils(simplealu_agent)

//analyis ports
uvm_analysis_port#(simplealu_transaction) agent_ap;

simplealu_driver sa_drvr;
simplealu_sequencer sa_seqr;
simplealu_monitor sa_mon;

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction: new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agent_ap = new(.name("agent_ap"), .parent(this));

    sa_drvr = simplealu_driver::type_id::create(.name("sa_drvr"), .parent(this));
    sa_seqr = simplealu_sequencer::type_id::create(.name("sa_seqr"), .parent(this));
    sa_mon = simplealu_monitor::type_id::create(.name("sa_mon"), .parent(this));
endfunction: build_phase

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    sa_drvr.seq_item_port.connect(sa_seqr.seq_item_export);
    sa_mon.mon_ap.connect(agent_ap);
endfunction: connect_phase
endclass: simplealu_agent
