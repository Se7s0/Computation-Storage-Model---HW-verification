module top ();

	parameter CLK_PERIOD = 100;
	
	bit clk;
	always #(CLK_PERIOD/2) clk = ~clk;
	
	module_if modif(clk);

	main m0(modif);
	tb t0(modif);


endmodule : top
