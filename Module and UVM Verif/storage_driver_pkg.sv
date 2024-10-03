package storage_driver_pkg;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_config_pkg::*;	
	import storage_seq_item_pkg::*;	

	class storage_driver extends uvm_driver #(storage_seq_item);

		`uvm_component_utils(storage_driver);

		virtual module_if modvif;
		storage_seq_item stim_seq_item;

		function new(string name = "storage_driver", uvm_component parent = null);

			super.new(name, parent);
			
		endfunction : new

		task run_phase(uvm_phase phase);

			super.run_phase(phase);
			stim_seq_item = storage_seq_item::type_id::create("stim_seq_item");

			forever begin
				
				seq_item_port.get_next_item(stim_seq_item);

					modvif.rst = stim_seq_item.rst;
					modvif.cmd = stim_seq_item.cmd;
					modvif.addA = stim_seq_item.addA;
					modvif.addB = stim_seq_item.addB;
					modvif.addC = stim_seq_item.addC;
					modvif.DQ_i = stim_seq_item.DQ_i;

					@(negedge modvif.clk);

				seq_item_port.item_done();

			end
			
		endtask : run_phase
		
	endclass : storage_driver

endpackage : storage_driver_pkg