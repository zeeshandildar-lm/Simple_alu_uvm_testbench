import uvm_pkg::*;
`include "uvm_macros.svh"
`include "simple_alu.v"
`include "simplealu_if.sv"
//`include "simplealu_pkg.sv"
    `include "simplealu_sequencer.sv"
	`include "simplealu_monitor.sv"
	`include "simplealu_driver.sv"
	`include "simplealu_agent.sv"
	`include "simplealu_scoreboard.sv"
	//`include "simplealu_config.sv"
	`include "simplealu_env.sv"
	`include "simplealu_test.sv"
    

module simplealu_tb_top;
//import uvm_pkg::*;

//interface declaration
simplealu_if vif();

//connect the interface to the DUT

simple_alu dut(vif.clk       ,
               vif.en_i      ,
               vif.en_o      ,
               vif.select_op ,
               vif.a         ,
               vif.b,
               vif.out);
initial begin
 //   uvm_config_db #(virtual simplealu_if)::set(.scope("ifs"), .name("simplealu_if"), .val(vif));
    uvm_config_db#(virtual simplealu_if)::set(null,"*","simplealu_vif",vif);  //set method

    run_test();
end

initial begin
    vif.clk = 1'b1;
end

//clock generation
always begin
    #5 vif.clk = ~vif.clk;
end
endmodule