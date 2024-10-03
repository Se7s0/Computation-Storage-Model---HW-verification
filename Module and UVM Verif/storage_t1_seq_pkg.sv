package storage_t1_seq_pkg;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_seq_item_pkg::*;	

	class storage_t1_seq extends  uvm_sequence #(storage_seq_item);
	
		`uvm_object_utils(storage_t1_seq)
		storage_seq_item seq_item;

		function new(string name = "storage_t1_seq");

			super.new(name);
			
		endfunction : new

		task body;
			
			repeat(10000) begin
				
				seq_item = storage_seq_item::type_id::create("seq_item");

				start_item(seq_item);

					assert(seq_item.randomize());

				finish_item(seq_item);

			end

		endtask : body
		
	endclass : storage_t1_seq

endpackage : storage_t1_seq_pkg
