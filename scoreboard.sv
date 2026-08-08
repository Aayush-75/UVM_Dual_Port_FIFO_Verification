`include "defines.sv"

class my_scb extends uvm_scoreboard;

    `uvm_component_utils(my_scb)

    seq_item ip;
    seq_item op;

    uvm_tlm_fifo#(seq_item) ip_fifo;
    uvm_tlm_fifo#(seq_item) op_fifo;

    bit [`DATA_WIDTH-1:0]mem[`RAM_DEPTH];
    bit [`ADDR_WIDTH-1:0]wr_counter;
    bit [`ADDR_WIDTH-1:0]rd_counter;
    bit [`DATA_WIDTH-1:0]data_out;

    int PASS,FAIL;

    function new(string name="my_scb",uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ip_fifo = new("ip_fifo",this);
        op_fifo = new("op_fifo",this);
    endfunction

    task run_phase(uvm_phase phasei);
        op_fifo.get(op);
        ip_fifo.get(ip);
        ref_model();
        check();
    endtask

    task ref_model();
        `uvm_info(get_type_name(),$sformatf("[%0t]: SCB: WR_CS=%0d RD_CS=%0d WR_EN=%0d RD_EN=%0d DATA_IN=%0d",$time,ip.wr_cs,ip.rd_cs,ip.wr_en,ip.rd_en,ip.data_in),UVM_MEDIUM);
        if(ip.wr_en && ip.wr_cs && (diff()!=(`RAM_DEPTH-1)))
            begin
                mem[wr_counter] = ip.data_in;
                wr_counter++;
            end
        if(ip.rd_en && ip.rd_cs && (diff()!=0))
            begin
                data_out = mem[rd_counter];
                rd_counter++;
            end
        if(diff() == 0)
            begin
                ip.empty = 1;
            end
        if(diff() == (`RAM_DEPTH-1))
            begin
                ip.full = 1;        
            end
    endtask

    function int diff();
        if(wr_counter-rd_counter<0)
            diff = rd_counter - wr_counter;
        else
            diff = wr_counter - rd_counter;
    endfunction

    task check();
        if(data_out==op.data_out && ip.full==op.full && ip.empty==op.empty)
            begin
                PASS++;
                $display("-------------------PASS:[%0d]---------------------------",PASS);
                `uvm_info(get_type_name(),$sformatf("[%0t]: SCB: DATA_OUT=%0d FULL=%0d EMPTY=%0d",$time,data_out,ip.full,ip.empty),UVM_MEDIUM);
                `uvm_info(get_type_name(),$sformatf("[%0t]: SCB: DATA_OUT=%0d FULL=%0d EMPTY=%0d",$time,op.data_out,op.full,op.empty),UVM_MEDIUM);
                $display("");
            end
        else 
            begin
                FAIL++;
                $display("-------------------FAIL:[%0d]---------------------------",FAIL);
                `uvm_info(get_type_name(),$sformatf("[%0t]: SCB: DATA_OUT=%0d FULL=%0d EMPTY=%0d",$time,data_out,ip.full,ip.empty),UVM_MEDIUM);
                `uvm_info(get_type_name(),$sformatf("[%0t]: SCB: DATA_OUT=%0d FULL=%0d EMPTY=%0d",$time,op.data_out,op.full,op.empty),UVM_MEDIUM);
                $display("");
            end
    endtask
endclass
