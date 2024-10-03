package storage_reset_seq_pkg;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_seq_item_pkg::*;	

	parameter CLK_PERIOD = 100;


	class storage_reset_seq extends  uvm_sequence #(storage_seq_item);
	
		`uvm_object_utils(storage_reset_seq)
		storage_seq_item seq_item;

		function new(string name = "storage_reset_seq");

			super.new(name);
			
		endfunction : new

		task body;
			
			seq_item = storage_seq_item::type_id::create("seq_item");

			start_item(seq_item);

				seq_item.rst = 1;
				seq_item.addA = 0;
				seq_item.addB = 0;
				seq_item.addC = 0;
				seq_item.cmd = 0;
				seq_item.DQ_i = 0;

				#(CLK_PERIOD)
	        	seq_item.rst = 1'b0;  
	        	#(CLK_PERIOD)
				seq_item.rst = 1'b1;

			finish_item(seq_item);

		endtask : body
		
	endclass : storage_reset_seq

endpackage : storage_reset_seq_pkg
