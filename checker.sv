`include "uvm_macros.svh"
import uvm_pkg::*;

module fifo_assertions
(
	input bit clk,
	input bit rst,
	input bit wr_en,
	input bit wr_cs,
	input bit rd_en,
	input bit rd_cs,
	input bit full,
	input bit empty,
	input bit [7:0]data_out
);

	property no_full_empty_same_time;
		@(posedge clk) !(full && empty);
	endproperty
	assert property(no_full_empty_same_time)
	else `uvm_error("ASSERTION","FULL AND EMPTY HAPPENED AT SAME TIME");
	
 	property empty_when_rst;
		@(posedge clk) rst |-> empty;
	endproperty
	assert property(empty_when_rst)
	else `uvm_error("ASSERTION","UPON RST EMPTY DIDN'T GO HIGH");

	property if_write_empty_remove;
		 @(posedge clk) (empty && wr_en && wr_cs && !(rd_cs && rd_en)) |=> !empty;
	endproperty
	assert property(if_write_empty_remove)
	else `uvm_error("ASSERTION","WRITE OPERATION AND NO READ OPERATION DIDN'T DEASSERT EMPTY");

	property if_read_full_remove;
		@(posedge clk) (full && rd_en && rd_cs && !(wr_cs && wr_en)) |=> !full;
	endproperty
	assert property(if_read_full_remove)
	else `uvm_error("ASSERTION","READ OPERATION AND NO WRITE OPERATION DIDN'T DEASSERT FULL");
endmodule
