class fifo_config extends uvm_object;

    `uvm_object_utils(fifo_config)

    virtual fifo_if intrf;

    uvm_active_passive_enum in_agent;
    uvm_active_passive_enum op_agent;

endclass
