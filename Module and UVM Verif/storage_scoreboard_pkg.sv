package storage_scoreboard_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import storage_seq_item_pkg::*;

	parameter mem_width = 16; //bits
	parameter mem_length = 8; //bits

	localparam 	RD_MEM_CMD = 2'b00,
         		WR_MEM_CMD = 2'b01,
         		ADD_CMD    = 2'b10,
         		SUB_CMD    = 2'b11;	

	class storage_scoreboard extends uvm_scoreboard;

		`uvm_component_utils(storage_scoreboard);
		uvm_analysis_export #(storage_seq_item) sb_export;
		uvm_tlm_analysis_fifo #(storage_seq_item) sb_fifo;

		storage_seq_item seq_item_sb;

  		logic [mem_width-1 : 0] ref_mem [2**mem_length-1 : 0];
  		logic [mem_width-1 : 0] ref_res;

		int error_count = 0;
		int correct_count = 0;

	    integer file;  // File handler

		virtual module_if modvif;

		function new(string name = "storage_scoreboard", uvm_component parent = null);

			super.new(name, parent);
			
		endfunction : new

		function void build_phase(uvm_phase phase);

			super.build_phase(phase);
			sb_export = new("sb_export", this);
			sb_fifo = new("sb_fifo", this);
			
		endfunction : build_phase

		function void connect_phase(uvm_phase phase);

			super.connect_phase(phase);
			sb_export.connect(sb_fifo.analysis_export);
			
		endfunction : connect_phase

		task run_phase(uvm_phase phase);

			super.run_phase(phase);
			forever begin
				
				sb_fifo.get(seq_item_sb);
				
				ref_model(seq_item_sb);

			end
			
		endtask : run_phase

		function void report_phase(uvm_phase phase);

			super.report_phase(phase);

			file = $fopen("memory_dump.txt", "w");

        	// Check if the file is successfully opened
        	if (file) begin
	            // Write the contents of the memory array to the file
	            for (int i = 0; i < 2**mem_length; i = i + 1)
	                $fwrite(file, "%0h\n", ref_mem[i]);
            end

            // Close the file
            $fclose(file);

            `uvm_info("report_phase", $sformatf("Total succesful reads: %0d", correct_count), UVM_MEDIUM);
            `uvm_info("report_phase", $sformatf("Total failed reads: %0d", error_count), UVM_MEDIUM);

		endfunction : report_phase

		task ref_model(storage_seq_item seq_item_chk);

			if (seq_item_chk.rst) begin

				$readmemb("mem_init.txt", ref_mem);

			end

			else begin
				
				case (seq_item_chk.cmd)

				        RD_MEM_CMD: begin
				        
				        	read_mem(seq_item_chk.addA);   
				        
				        end
				        
				        WR_MEM_CMD: begin
				        
				        	write_mem(seq_item_chk.addC, seq_item_chk.DQ_i);
				        
				        end
				        
				        ADD_CMD: begin

				        	add(seq_item_chk.addA, seq_item_chk.addB, seq_item_chk.addC);

				        end
				        
				        SUB_CMD: begin

				        	sub(seq_item_chk.addA, seq_item_chk.addB, seq_item_chk.addC);

				        end
				        
				endcase

			end
			
		endtask : ref_model

	    task automatic read_mem(input [mem_length-1 : 0] addr);
	        begin

				ref_res = ref_mem[addr];

				@(negedge modvif.clk);

				if (ref_res == seq_item_sb.DQ_o) begin
					correct_count = correct_count + 1;
				end
				else error_count = error_count + 1;

	        end
	    endtask

	    task automatic write_mem(input [mem_length-1 : 0] addr, input [mem_width-1 : 0] data);
	        begin

	            ref_mem[addr] = data;

	        end
	    endtask

	    task automatic add(input [mem_length-1 : 0] addrA, input [mem_length-1 : 0] addrB, input [mem_length-1 : 0] addrC);
	        begin

	            ref_mem[addrC] = ref_mem[addrA] + ref_mem[addrB];

	        end
	    endtask	    

	    task automatic sub(input [mem_length-1 : 0] addrA, input [mem_length-1 : 0] addrB, input [mem_length-1 : 0] addrC);
	        begin

	            ref_mem[addrC] = ref_mem[addrA] - ref_mem[addrB];
	      
	        end
	    endtask
		
	endclass : storage_scoreboard
	
endpackage : storage_scoreboard_pkg
