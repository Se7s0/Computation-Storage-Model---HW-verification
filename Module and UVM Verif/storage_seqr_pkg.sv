package storage_seqr_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_seq_item_pkg::*;	

	class storage_seqr extends uvm_sequencer #(storage_seq_item);

		`uvm_component_utils(storage_seqr);

		function new(string name = "storage_seqr", uvm_component parent = null);
			
			super.new(name);

		endfunction : new
		
	endclass : storage_seqr
	
endpackage : storage_seqr_pkg
