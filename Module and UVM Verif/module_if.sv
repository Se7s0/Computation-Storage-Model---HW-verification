interface module_if (clk);

	//memory will be 16 bit width with 256 words
	parameter mem_width = 16; //bits
	parameter mem_length = 8; //bits
	parameter CLK_PERIOD = 100;


	input bit clk;
	logic rst;
	logic [1:0] cmd; 							// Command: 0-RD_MEM_CMD, 1-WR_MEM_CMD, 2-ADD_CMD, 3-SUB_CMD
	logic [mem_length-1 : 0] addA, addB, addC; 	//addresses 
	logic [mem_width-1 : 0] DQ_i, DQ_o;		//databusses

	modport TEST (	input clk, DQ_o, 
					output rst, addA, addB, addC, cmd, DQ_i);
	
	modport DUT (	input clk, rst, addA, addB, addC, cmd, DQ_i,
					output DQ_o);
	
endinterface : module_if
