class test extends uvm_test;

    `uvm_component_utils(test)
    
    fifo_config my_config;
    my_sequence seq;
    environment env;
    
    function new(string name="test",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(fifo_config)::get(this,"","intrf",my_config))
            `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG FILE");
        env = environment::type_id::create("env",this);
        my_config.in_agent = UVM_ACTIVE;
        my_config.op_agent = UVM_PASSIVE;
        sqr = my_sequencer::type_id::create("sqr",this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection();
        seq1::type_id::set_type_override(seq_item::type_id);
        repeat(300) seq.start(env.ip_agent.sqr);
        seq2::type_id::set_type_override(seq_item::type_id);
        repeat(300) seq.start(env.ip_agent.sqr);
        seq1::type_id::set_type_override(seq_item::type_id);
        repeat(30) seq.start(env.ip_agent.sqr);
        seq3::type_id::set_type_override(seq_item::type_id);
        repeat(200) seq.start(env.ip_agent.sqr);
        seq1::type_id::set_type_override(seq_item::type_id);
        repeat(50) seq.start(env.ip_agent.sqr);
        seq4::type_id::set_type_override(seq_item::type_id);
        repeat(50) seq.start(env.ip_agent.sqr);
        seq5::type_id::set_type_override(seq_item::type_id);
        repeat(50) seq.start(env.ip_agent.sqr);
        seq2::type_id::set_type_override(seq_item::type_id);
        repeat(5) seq.start(env.ip_agent.sqr);
        seq6::type_id::set_type_override(seq_item::type_id);
        repeat(50) seq.start(env.ip_agent.sqr);
        seq7::type_id::set_type_override(seq_item::type_id);
        repeat(50) seq.start(env.ip_agent.sqr);
        seq2::type_id::set_type_override(seq_item::type_id);
        repeat(100) seq.start(env.ip_agent.sqr);
        phase.raise_objection();
    endtask
endclass