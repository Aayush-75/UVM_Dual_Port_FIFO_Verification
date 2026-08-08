class ip_mon extends uvm_monitor;

    `uvm_component_utils(ip_mon)

    virtual fifo_if.ip_mon_mod intrf;
    fifo_config my_config;
    seq_item my_seq_item;
    uvm_analysis_port#(seq_item) ip_mon_analysis_port;

    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(fifo_config)::get(this,"","intrf",my_config))
            `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG FILE");
	ip_mon_analysis_port = new("ip_mon_analysis_port", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        intrf = my_config.intrf;
    endfunction

    task run_phase(uvm_phase phase);
        repeat(2) @(posedge intrf.clk); //to make forever start at active region of 30
        forever 
        begin
            @(intrf.ip_mon_cb); //this will unblock at reactive region of 30
            my_seq_item = seq_item::type_id::create("my_seq_item");
            my_seq_item.wr_cs = intrf.ip_mon_cb.wr_cs;
            my_seq_item.rd_cs = intrf.ip_mon_cb.rd_cs;
            my_seq_item.wr_en = intrf.ip_mon_cb.wr_en;
            my_seq_item.rd_en = intrf.ip_mon_cb.rd_en;
            my_seq_item.data_in = intrf.ip_mon_cb.data_in;
            ip_mon_analysis_port.write(my_seq_item);
            `uvm_info(get_type_name(),$sformatf("[%0t]: IP_MON: WR_CS=%0d RD_CS=%0d WR_EN=%0d RD_EN=%0d DATA_IN=%0d",$time,my_seq_item.wr_cs,my_seq_item.rd_cs,my_seq_item.wr_en,my_seq_item.rd_en,my_seq_item.data_in),UVM_MEDIUM);
        end
    endtask

endclass
