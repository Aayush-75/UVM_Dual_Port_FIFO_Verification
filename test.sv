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
	my_config = fifo_config::type_id::create("my_config");
        if(!uvm_config_db#(virtual fifo_if)::get(this,"","intrf",my_config.intrf))
            `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG FILE");
        env = environment::type_id::create("env",this);
        my_config.in_agent = UVM_ACTIVE;
        my_config.op_agent = UVM_PASSIVE;
	uvm_config_db#(fifo_config)::set(this,"*","intrf",my_config);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
	seq = my_sequence::type_id::create("seq");
        seq_item::type_id::set_type_override(seq1::get_type());
        repeat(300) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq2::get_type());
        repeat(300) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq1::get_type());
        repeat(30) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq3::get_type());
        repeat(200) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq1::get_type());
        repeat(50) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq4::get_type());
        repeat(50) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq5::get_type());
        repeat(50) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq2::get_type());
        repeat(5) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq6::get_type());
        repeat(50) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq7::get_type());
        repeat(50) seq.start(env.ia.sqr);
        seq_item::type_id::set_type_override(seq2::get_type());
        repeat(100) seq.start(env.ia.sqr);
        phase.raise_objection(this);
    endtask
endclass
