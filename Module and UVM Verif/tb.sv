module tb (module_if.TEST modif);

  	logic [modif.mem_width-1 : 0] local_mem [2**modif.mem_length-1 : 0];
  	logic [modif.mem_width-1 : 0] local_res;
  	int errors;


  	initial begin

  		$readmemb("mem_init.txt", local_mem);

  		reset_seq();
  		
  		write_mem(8'h00, 8'hAA);
  		write_mem(8'h01, 8'hAB);
  		write_mem(8'h02, 8'hBA);
  		write_mem(8'h03, 8'hBB);

  		read_mem(8'h00);
  		read_mem(8'h01);
  		read_mem(8'h02);
  		read_mem(8'h03);

  		add(8'h00, 8'h01, 8'h04);

  		sub(8'h00, 8'h01, 8'h04);
  		sub(8'h09, 8'h09, 8'h10);


  	end


	//Task to reset
	task automatic reset_seq();
		begin
			
			modif.rst = 1'b1;
        	#(modif.CLK_PERIOD)
        	modif.rst = 1'b0;  
        	#(modif.CLK_PERIOD)
			modif.rst = 1'b1;
	
		end
		
	endtask : reset_seq
	
	// Task to issue a read memory command (RD_MEM_CMD)
    task automatic read_mem(input [modif.mem_width-1 : 0] addr);
        begin

            modif.cmd = 2'b00;    
            modif.addA = addr;

            @(posedge modif.clk)

            local_res = local_mem[addr];
       		check_res();
        
        end
    endtask

	// Task to issue a write memory command (WR_MEM_CMD)
    task automatic write_mem(input [modif.mem_width-1 : 0] addr, input [modif.mem_length-1 : 0] data);
        begin

            modif.cmd = 2'b01;    
            modif.addC = addr;   
            modif.DQ_i = data;

            @(posedge modif.clk)

            local_mem[addr] = data;

        end
    endtask

    // Task to perform add operation (ADD_CMD)
    task automatic add(input [modif.mem_width-1 : 0] addrA, input [modif.mem_width-1 : 0] addrB, input [modif.mem_width-1 : 0] addrC);
        begin

            modif.cmd = 2'b10;      
            modif.addA = addrA;      
            modif.addB = addrB;    
            modif.addC = addrC;

            @(posedge modif.clk)

            local_mem[addrC] = local_mem[addrA] + local_mem[addrB];
            local_res = local_mem[addrC];
      		check_res();
       
      
        end
    endtask

    // Task to perform subtract operation (SUB_CMD)
    task automatic sub(input [modif.mem_width-1 : 0] addrA, input [modif.mem_width-1 : 0] addrB, input [modif.mem_width-1 : 0] addrC);
        begin

            modif.cmd = 2'b11;        
            modif.addA = addrA;    
            modif.addB = addrB;      
            modif.addC = addrC;

            @(posedge modif.clk)

			local_mem[addrC] = local_mem[addrA] - local_mem[addrB];
            local_res = local_mem[addrC];  
            check_res();     

     
        end
    endtask

    task automatic check_res();

    	begin

    		@(posedge modif.clk)	
    		
    		if (local_res != modif.DQ_o) begin
    		
    			errors = errors + 1;
    		
    		end

    		else $display("matched");

    	end

    endtask

endmodule : tb
