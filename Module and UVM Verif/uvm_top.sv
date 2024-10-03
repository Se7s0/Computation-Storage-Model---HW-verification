import uvm_pkg::*;
`include "uvm_macros.svh"

import storage_test_pkg::*;

module uvm_top ();

	parameter CLK_PERIOD = 100;

	bit clk;
	
	always #(CLK_PERIOD/2) clk = ~clk;

	module_if modif(clk);
	main m0(modif);

	initial begin
		
		uvm_config_db#(virtual module_if)::set(null, "uvm_test_top", "storage_if", modif);
		run_test("storage_test");

	end


endmodule : uvm_top
