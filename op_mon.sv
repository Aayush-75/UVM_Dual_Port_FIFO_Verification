class op_mon extends uvm_monitor;

    `uvm_component_utils(op_mon)

    virtual fifo_if.op_mon_mod intrf;
    fifo_config my_config;
    seq_item my_seq_item;
    uvm_analysis_port#(seq_item) op_mon_analysis_port;

    function new(string name="op_mon",uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(fifo_config)::get(this,"","intrf",my_config))
            `uvm_fatal(get_type_name(),"FAILED TO ATTACH CONFIG FILE");
	op_mon_analysis_port = new("op_mon_analysis_port", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        intrf = my_config.intrf;
    endfunction

    task run_phase(uvm_phase phase);
        repeat(2) @(posedge intrf.clk);
        forever 
            begin
                @(intrf.op_mon_cb);
                my_seq_item = seq_item::type_id::create("my_seq_item");
                my_seq_item.data_out = intrf.op_mon_cb.data_out;
                my_seq_item.full = intrf.op_mon_cb.full;
                my_seq_item.empty = intrf.op_mon_cb.empty;
                op_mon_analysis_port.write(my_seq_item);
                `uvm_info(get_type_name(),$sformatf("[%0t]: OP_MON: DATA_OUT=%0d FULL=%0d EMPTY=%0d",$time,my_seq_item.data_out,my_seq_item.full,my_seq_item.empty),UVM_MEDIUM);
            end
    endtask

endclass
