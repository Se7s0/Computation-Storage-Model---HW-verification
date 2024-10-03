module main (module_if.DUT modif);

  	logic [modif.mem_width-1 : 0] memory [2**modif.mem_length-1 : 0];

	localparam 	RD_MEM_CMD = 2'b00,
	         	WR_MEM_CMD = 2'b01,
	         	ADD_CMD    = 2'b10,
	         	SUB_CMD    = 2'b11;

  	always_ff @(posedge modif.clk or posedge modif.rst) begin //seq logic to assign the result
  	
	  	if(modif.rst) begin
	  	
	  		modif.DQ_o <= 0;
	  		$readmemb("mem_init.txt", memory);
	  	
	  	end else begin
	  	
			case (modif.cmd)

			        RD_MEM_CMD: begin
			        
			          modif.DQ_o <= memory[modif.addA];      
			        
			        end
			        
			        WR_MEM_CMD: begin
			        
			          memory[modif.addC] <= modif.DQ_i;
			        
			        end
			        
			        ADD_CMD: begin
			          
			          memory[modif.addC] <= memory[modif.addA] + memory[modif.addB];   

			        end
			        
			        SUB_CMD: begin

			          memory[modif.addC] <= memory[modif.addA] - memory[modif.addB];   


			        end
			        
			endcase
	  	
	  	end
  	end


endmodule : main
