class my_driver extends uvm_driver#(seq_item);

    `uvm_component_utils(my_driver)

    virtual if_fifo.drv_mod intrf;
    fifo_config my_config;

    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(fifo_config)::get(this,"","intrf",my_config))
            `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG FILE");
    endfunction

    function void connect_phase(uvm_phase phase);
        intrf = my_config.intrf;
    endfunction

    task run_phase(uvm_phase phase);
        @(posedge intrf.clk); //to make start at active region of 10
        forever 
        begin
           @(intrf.drv_cb); //to make start at reactive region of 10
           seq_item_port.get_next_item(req);
           drive();
           seq_item_port.item_done(req); 
        end
    endtask

    task drive();
        intrf.drv_cb.wr_cs <= req.wr_cs;
        intrf.drv_cb.rd_cs <= req.rd_cs;
        intrf.drv_cb.wr_en <= req.wr_en; 
        intrf.drv_cb.rd_en <= req.rd_en;
        intrf.drv_cb.data_in <= req.data_in;
    endtask

endclass
