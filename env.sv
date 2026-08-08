class environment extends uvm_environment;


    `uvm_component_utils(environment)

    ip_agent ia;
    op_agent oa;
    my_scb scb;

    function new(string name="environment",uvm_component parent = null)
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ia = ip_agent::type_id::create("ip_agent",this);
        oa = op_agent::type_id::create("op_agent",this);
        scb = my_scb::type_id:create("scb",this);
    endfunction

    function void connect_phase(uvm_phase phase)
        ia.mon.ip_mon_analysis_port.connect(scb.ip_fifo);
        oa.mon.op_mon_analysis_port.connect(scb.op_fifo);
    endfunction
    
endclass