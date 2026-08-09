class my_coverage extends uvm_subscriber#(seq_item);

	`uvm_component_utils(my_coverage)

	seq_item seq;
	
	covergroup cg;
	c1: coverpoint seq.wr_cs;
	c2: coverpoint seq.wr_en;
	c3: coverpoint seq.rd_cs;
	c4: coverpoint seq.rd_en;
	c5: coverpoint seq.data_in
	{
		option.auto_bin_max = 1;
	}
	endgroup

	function new(string name="my_coverage",uvm_component parent=null);
		super.new(name,parent);
		cg = new;
	endfunction

	function void write(seq_item t);
		seq = t;
		cg.sample();		
	endfunction

endclass
