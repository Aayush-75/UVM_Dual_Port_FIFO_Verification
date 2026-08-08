`include "pkg.sv"
`include "ram_dp_ar_aw.sv"
`include "syn_fifo.sv"

module top;

    import uvm_pkg::*;
	import pkg::*;

    bit clk,rst;

    fifo_if DUV_IF(clk,rst);

    syn_fifo DUV(clk,rst,DUV_IF.wr_cs,DUV_IF.rd_cs,DUV_IF.data_in,DUV_IF.rd_en,DUV_IF.wr_en,DUV_IF.data_out,DUV_IF.full,DUV_IF.empty);

    initial
		forever 
		   #10 clk=~clk;

 	initial
	begin
		uvm_config_db#(virtual fifo_if)::set(null,"*","intrf",DUV_IF);
	        run_test("test");
	end	
    
endmodule
