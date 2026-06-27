/**
 * @file    axi_st.sv
 * @brief   Define the standard AXI-ST signals as an interface file.
 *
 * @details As always with me, the file implement the "complete" spec as referenced on the website.
 *          Not all signals are required and are driven, therefore depending on the synthesis tool, not
 *          all signals may be present.
 *
 * @author  l.heywang <leonard.heywang@proton.me>
 * @date    26/06/2026
 *
 * @copyright l.heywang, MIT License.
 */

interface axi_st #(
    parameter int TDATA_WIDTH = 32,
    parameter int TID_WIDTH = 4,
    parameter int TDEST_WIDTH = 4,
    parameter int TUSER_WIDTH = 1
);

    // Mandatory signals
    logic                               tvalid;
    logic                               tready;
    logic [TDATA_WIDTH -1 : 0]          tdata;
    logic [(TDATA_WIDTH / 8) - 1 : 0]   tstrb;
    logic [(TDATA_WIDTH / 8) - 1 : 0]   tkeep;
    logic                               tlast;
    logic [TID_WIDTH : 0]               tid;
    logic [TDEST_WIDTH : 0]             tdest;
    logic [TUSER_WIDTH : 0]             tuser;
    logic                               twakeup;

    modport source (
        output  tvalid,
        output  tdata,
        output  tstrb,
        output  tkeep,
        output  tlast,
        output  tid,
        output  tdest,
        output  tuser,
        output  twakeup,
        input   tready
    );

    modport sink (
        input   tvalid,
        input   tdata,
        input   tstrb,
        input   tkeep,
        input   tlast,
        input   tid,
        input   tdest,
        input   tuser,
        input   twakeup,
        output  tready
    );

endinterface: axi_st
