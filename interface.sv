`include "defines.sv"

interface fifo_if(clk,rst);

    bit wr_cs,rd_cs,wr_en,rd_en;
    bit [`DATA_WIDTH:0]data_in;

    bit full,empty;
    bit [`DATA_WIDTH:0] data_out;

    clocking drv_cb @(posedge clk);
        default input #1 output #0;
        output wr_cs,rd_cs,wr_en,rd_en,data_in;
    endclocking 

    clocking in_mon_cb @(posedge clk);
        default input #1 output #0;
        input full,empty,data_out;
    endclocking 

    clocking op_mon_cb @(posedge clk);
        default input #1 output #0;
        input full,empty,data_out;
    endclocking 


    modport drv_mod(clocking drv_cb, input clk,rst);
    modport ip_mon_mod(clocking inp_mon_cb, input clk,rst);
    modport op_mon_mod(clocking op_mon_cb, input clk,rst);
endinterface
