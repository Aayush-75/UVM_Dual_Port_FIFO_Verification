`include "defines.sv"

class seq_item extends uvm_seq_item;

    `uvm_object_utils(seq_item)

    rand bit wr_cs,rd_cs,wr_en,rd_en;
    rand bit [`DATA_WIDTH:0]data_in;

    bit full,empty;
    bit [`DATA_WIDTH:0] data_out;

endclass

class seq1 extends seq_item; //only write operation
    
    `uvm_object_utils(seq1)

    constraint c1
    {
        wr_cs==1;
        wr_en==1;
        rd_cs==0;
        rd_en==0;
    }

endclass

class seq2 extends seq_item; //only read operation
    
    `uvm_object_utils(seq2)

    constraint c1
    {
        wr_cs==0;
        wr_en==0;
        rd_cs==1;
        rd_en==1;
    }
    
endclass

class seq3 extends seq_item; //both simeltanious operation 
    
    `uvm_object_utils(seq3)

    constraint c1
    {
        wr_cs==1;
        wr_en==1;
        rd_cs==1;
        rd_en==1;
    }
    
endclass

class seq4 extends seq_item; //only wr_cs operation
    
    `uvm_object_utils(seq4)

    constraint c1
    {
        wr_cs==1;
        wr_en==0;
        rd_cs==0;
        rd_en==0;
    }
    
endclass

class seq5 extends seq_item; //only wr_en operation
    
    `uvm_object_utils(seq5)

    constraint c1
    {
        wr_cs==0;
        wr_en==1;
        rd_cs==0;
        rd_en==0;
    }
    
endclass

class seq6 extends seq_item; //only rd_cs operation
    
    `uvm_object_utils(seq6)

    constraint c1
    {
        wr_cs==0;
        wr_en==0;
        rd_cs==1;
        rd_en==0;
    }
    
endclass

class seq7 extends seq_item; //only rd_en operation
    
    `uvm_object_utils(seq7)

    constraint c1
    {
        wr_cs==0;
        wr_en==0;
        rd_cs==0;
        rd_en==1;
    }
    
endclass