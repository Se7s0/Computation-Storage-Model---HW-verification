package storage_monitor_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_seq_item_pkg::*;	

	class storage_monitor extends uvm_monitor;
	
		`uvm_component_utils(storage_monitor);

		virtual module_if modvif;
		storage_seq_item rsp_seq_item;
		uvm_analysis_port #(storage_seq_item) mon_ap;

		function new(string name = "storage_monitor", uvm_component parent = null);
			
			super.new(name, parent);

		endfunction : new

		function void build_phase(uvm_phase phase);

			super.build_phase(phase);
			mon_ap = new("mon_ap", this);
			
		endfunction : build_phase

		task run_phase(uvm_phase phase);

			super.run_phase(phase);
			
			forever begin
				
				rsp_seq_item = storage_seq_item::type_id::create("rsp_seq_item");

				@(negedge modvif.clk)

					rsp_seq_item.rst = modvif.rst;
					rsp_seq_item.cmd = modvif.cmd;
					rsp_seq_item.addA = modvif.addA;
					rsp_seq_item.addB = modvif.addB;
					rsp_seq_item.addC = modvif.addC;
					rsp_seq_item.DQ_i = modvif.DQ_i;
					rsp_seq_item.DQ_o = modvif.DQ_o;

				mon_ap.write(rsp_seq_item);

			end
			
		endtask : run_phase
		
	endclass : storage_monitor
	
endpackage : storage_monitor_pkg


