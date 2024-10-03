package storage_test_pkg;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_env_pkg::*;
	import storage_config_pkg::*;
	import storage_t1_seq_pkg::*;
	import storage_reset_seq_pkg::*;

	class storage_test extends uvm_test;

		`uvm_component_utils(storage_test);

		storage_env env;
		storage_config storage_cfg;
		virtual module_if modvif;
		storage_reset_seq rst_seq;
		storage_t1_seq t1_seq;

		function new(string name = "storage_test", uvm_component parent = null);

			super.new(name, parent);
			
		endfunction : new

		function void build_phase(uvm_phase phase);

			super.build_phase(phase);
			env = storage_env::type_id::create("env", this);
			storage_cfg = storage_config::type_id::create("config", this);
			rst_seq = storage_reset_seq::type_id::create("rst_seq", this);
			t1_seq = storage_t1_seq::type_id::create("t1_seq", this);

				if (!uvm_config_db#(virtual module_if)::get(this, "", "storage_if", storage_cfg.modvif)) begin
					`uvm_fatal("build_phase", "Test - Unable to get the virtual interface of the ALU from the uvm_config_db")
				end

			uvm_config_db#(storage_config)::set(this, "*", "CFG", storage_cfg);
			
		endfunction : build_phase

		task run_phase(uvm_phase phase);

			super.run_phase(phase);
			phase.raise_objection(this);

			rst_seq.start(env.agt.sqr);

			t1_seq.start(env.agt.sqr);

			phase.drop_objection(this);
			
		endtask : run_phase
		
	endclass : storage_test

endpackage : storage_test_pkg