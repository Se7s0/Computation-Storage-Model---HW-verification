package storage_config_pkg;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class storage_config extends uvm_object;

		`uvm_object_utils(storage_config);

		virtual module_if modvif;

		function new(string name = "storage_config");

			super.new(name);
			
		endfunction : new
		
	endclass : storage_config

endpackage : storage_config_pkg
