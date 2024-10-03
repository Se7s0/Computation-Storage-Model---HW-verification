package storage_coverage_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_seq_item_pkg::*;	

	class storage_coverage extends uvm_component;

		`uvm_component_utils(storage_coverage);
		uvm_analysis_export #(storage_seq_item) cov_export;
		uvm_tlm_analysis_fifo #(storage_seq_item) cov_fifo;

		storage_seq_item seq_item_cov;

		//covergroups

		function new(string name = "storage_coverage", uvm_component parent = null);

			super.new(name, parent);
			//create the covergroups
			
		endfunction : new

		function void build_phase(uvm_phase phase);

			super.build_phase(phase);
			cov_export = new("cov_export", this);
			cov_fifo = new("cov_fifo", this);
			
		endfunction : build_phase

		function void connect_phase(uvm_phase phase);

			super.connect_phase(phase);
			cov_export.connect(cov_fifo.analysis_export);
			
		endfunction : connect_phase

		task run_phase(uvm_phase phase);

			super.run_phase(phase);
			forever begin
				
				cov_fifo.get(seq_item_cov);
				//sample() methods

			end
			
		endtask : run_phase

		
	endclass : storage_coverage
	
endpackage : storage_coverage_pkg
