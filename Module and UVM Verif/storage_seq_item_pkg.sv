package storage_seq_item_pkg;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	parameter mem_width = 16; //bits
	parameter mem_length = 8; //bits
	
	class storage_seq_item extends uvm_sequence_item;

		`uvm_object_utils(storage_seq_item)

		bit rst;
		rand logic [1:0] cmd;
		rand logic [mem_length-1 : 0] addA, addB, addC; 	//addresses 
		rand logic [mem_width-1 : 0] DQ_i;				//databusses

		logic [mem_width-1 : 0] DQ_o;

		function new(string name = "storage_seq_item");

			super.new(name);
			
		endfunction : new


		//more functions
		
	
	endclass : storage_seq_item

endpackage : storage_seq_item_pkg