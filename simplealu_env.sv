class simplealu_env extends uvm_env;
    `uvm_component_utils(simplealu_env)
    simplealu_agent         sa_agent;
    simplelalu_scoreboard   sa_sb;

    function new(string name, parent);
        super.new(name);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sa_agent = simplealu_agent::type_id::create(.name("sa_agent"), .parent(this));
        sa_sb    = simplelalu_scoreboard::type_id::create(.name("sa_sb"), .parent(this));
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sa_agent.agent_ap.connect(sa_sb.sb_export);
    endfunction: connect_phase
endclass: simplealu_env