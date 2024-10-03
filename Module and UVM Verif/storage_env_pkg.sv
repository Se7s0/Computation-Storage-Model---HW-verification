package storage_env_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_agent_pkg::*;
	import storage_coverage_pkg::*;
	import storage_scoreboard_pkg::*;
	import storage_config_pkg::*;	


	class storage_env extends uvm_env;

		`uvm_component_utils(storage_env);

		storage_agent agt;
		storage_coverage cov;
		storage_scoreboard sb;
		storage_config storage_cfg;


		function new(string name = "storage_env", uvm_component parent = null);

			super.new(name, parent);
			
		endfunction : new

		function void build_phase(uvm_phase phase);

			super.build_phase(phase);

			if (!uvm_config_db#(storage_config)::get(this, "", "CFG", storage_cfg)) begin
				`uvm_fatal("build_phase", "Unable to get config obj");
			end

			agt = storage_agent::type_id::create("agt", this);
			sb = storage_scoreboard::type_id::create("sb", this);
			cov = storage_coverage::type_id::create("cov", this);
			
		endfunction : build_phase

		function void connect_phase(uvm_phase phase);

			agt.mon.mon_ap.connect(sb.sb_export);
			agt.mon.mon_ap.connect(cov.cov_export);

			sb.modvif = storage_cfg.modvif;


		endfunction : connect_phase
		
	endclass : storage_env
	
endpackage : storage_env_pkg