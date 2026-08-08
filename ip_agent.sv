class ip_agent extends uvm_agent;

    `uvm_component_utils(ip_agent)

    fifo_config my_config;
    my_driver drv;
    ip_mon mon;
    my_sequencer sqr;

    function new(string name="ip_agent", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phases phase);
        if(!uvm_config_db#(fifo_config)::get(this,"","intrf",my_config))
            `uvm_fatal(get_type_name(),"FAILED TO GET CONFIGURATION FILE")
        if(my_config.in_agent == UVM_ACTIVE)
            begin
                drv = my_driver::type_id::create("drv");
                sqr = my_sequencer::type_id::create("sqr");
            end
        mon = ip_mon::type_id::create("mon");
    endfunction

endclass
