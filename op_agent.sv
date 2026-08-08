class op_agent extends uvm_agent;

    `uvm_component_utils(op_agent)

    fifo_config my_config;
    my_driver drv;
    op_mon mon;
    my_sequencer sqr;

    function new(string name="op_agent", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
	super.build_phase(phase);
        if(!uvm_config_db#(fifo_config)::get(this,"","intrf",my_config))
            `uvm_fatal(get_type_name(),"FAILED TO GET CONFIGURATION FILE")
        if(my_config.op_agent == UVM_PASSIVE)
            begin
                mon = op_mon::type_id::create("mon",this);
            end
    endfunction

endclass
