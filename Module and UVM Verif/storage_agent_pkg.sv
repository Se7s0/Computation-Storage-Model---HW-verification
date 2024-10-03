package storage_agent_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_config_pkg::*;	
	import storage_seqr_pkg::*;	
	import storage_driver_pkg::*;	
	import storage_monitor_pkg::*;	
	
	class storage_agent extends uvm_agent;

		`uvm_component_utils(storage_agent);
		
		storage_config storage_cfg;
		storage_seqr sqr;
		storage_driver driver;
		storage_monitor mon;

		function new(string name = "storage_agent", uvm_component parent = null);

			super.new(name, parent);
			
		endfunction : new

		function void build_phase(uvm_phase phase);

			super.build_phase(phase);

			if (!uvm_config_db#(storage_config)::get(this, "", "CFG", storage_cfg)) begin
				`uvm_fatal("build_phase", "Unable to get config obj");
			end

			driver = storage_driver::type_id::create("driver", this);
			sqr = storage_seqr::type_id::create("sqr", this);
			mon = storage_monitor::type_id::create("mon", this);
			
		endfunction : build_phase

		function void connect_phase(uvm_phase phase);

			driver.modvif = storage_cfg.modvif;
			mon.modvif = storage_cfg.modvif;

			driver.seq_item_port.connect(sqr.seq_item_export);
			
		endfunction : connect_phase


	endclass : storage_agent

endpackage : storage_agent_pkg
