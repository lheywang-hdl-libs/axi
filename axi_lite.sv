/**
* @file    axi_lite.sv
* @brief   Define the standard AXI-Lite signals as an interface file.
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

interface axi_lite #(
    parameter int                       ADDR_WIDTH = 32,
    parameter int                       DATA_WIDTH = 32,
    parameter int                       ID_W_WIDTH = 0,
    parameter int                       USER_REQ_WIDTH = 0,
    parameter int                       USER_RESP_WIDTH = 0,
    parameter int                       SUBSYSID_WIDTH = 0,
    parameter int                       USER_DATA_WIDTH = 0,
    parameter int                       BRESP_WIDTH = 2
);

    // =============================
    // AW CHANNEL (ADDR)
    // =============================
    // address
    logic [ADDR_WIDTH - 1 : 0]          awaddr;

    // handshake
    logic                               awvalid;
    logic                               awready;

    // protection
    logic [2 : 0]                       awprot;

    // id
    logic [ID_W_WIDTH : 0]              awid;
    logic [SUBSYSID_WIDTH : 0]          awsubsysid;
    logic                               awidunq;

    // size
    logic [2 : 0]                       awsize;

    // user
    logic [USER_REQ_WIDTH : 0]          awuser;

    // trace
    logic                               awtrace;

    // wake up
    logic                               awakeup;

    // =============================
    // W CHANNEL (DATA)
    // =============================
    // data
    logic [DATA_WIDTH - 1 : 0]          wdata;

    // handshake
    logic                               wvalid;
    logic                               wready;

    // user
    logic [USER_DATA_WIDTH : 0]         wuser;

    // strobe
    logic [(DATA_WIDTH / 8) - 1 : 0]    wstrb;

    // poison
    logic                               wpoison;

    // =============================
    // B CHANNEL (RESP)
    // =============================
    // response
    logic [BRESP_WIDTH - 1: 0]          bresp;

    // handshake
    logic                               bvalid;
    logic                               bready;

    // id
    logic [ID_W_WIDTH : 0]              bid;
    logic                               bidunq;

    // user
    logic [USER_RESP_WIDTH : 0]         buser;

    // trace
    logic                               btrace;

    // =============================
    // AR CHANNEL (ADDR)
    // =============================
    // address
    logic [ADDR_WIDTH - 1 : 0]          araddr;

    // handshake
    logic                               arvalid;
    logic                               arready;
    logic [2 : 0]                       arprot;

    // id
    logic [ID_W_WIDTH : 0]              arid;
    logic [SUBSYSID_WIDTH : 0]          arsubsysid;
    logic                               aridunq;

    // user
    logic [USER_REQ_WIDTH : 0]          aruser;

    // trace
    logic                               artrace;

    // =============================
    // R CHANNEL (DATA)
    // =============================
    // data & response
    logic [DATA_WIDTH - 1 : 0]          rdata;
    logic [BRESP_WIDTH - 1: 0]          rresp;

    // handshake
    logic                               rvalid;
    logic                               rready;

    // id
    logic [ID_W_WIDTH : 0]              rid;
    logic                               ridunq;

    // user
    logic [USER_RESP_WIDTH : 0]         ruser;

    // trace
    logic                               rtrace;

    // poison
    logic                               rpoison;

    // =============================
    // MASTER
    // =============================
    modport master (
        // AW Channel
        output  awaddr,
        output  awvalid,
        input   awready,
        output  awprot,
        output  awid,
        output  awsubsysid,
        output  awidunq,
        output  awsize,
        output  awuser,
        output  awtrace,
        output  awakeup,

        // W channel
        output  wdata,
        output  wvalid,
        input   wready,
        output  wuser,
        output  wstrb,
        output  wpoison,

        // B channel
        input   bresp,
        input   bvalid,
        output  bready,
        input   bid,
        input   bidunq,
        input   buser,
        input   btrace,

        // AR channel
        output  araddr,
        output  arvalid,
        input   arready,
        output  arprot,
        output  arid,
        output  arsubsysid,
        output  aridunq,
        output  aruser,
        output  artrace,

        // R channel
        input   rdata,
        input   rresp,
        input   rvalid,
        output  rready,
        input   rid,
        input   ridunq,
        input   ruser,
        input   rtrace,
        input   rpoison
    );

    // =============================
    // CLIENT
    // =============================
    modport client (
        // AW Channel
        input   awaddr,
        input   awvalid,
        output  awready,
        input   awprot,
        input   awid,
        input   awsubsysid,
        input   awidunq,
        input   awsize,
        input   awuser,
        input   awtrace,
        input   awakeup,

        // W channel
        input   wdata,
        input   wvalid,
        output  wready,
        input   wuser,
        input   wstrb,
        input   wpoison,

        // B channel
        output  bresp,
        output  bvalid,
        input   bready,
        output  bid,
        output  bidunq,
        output  buser,
        output  btrace,

        // AR channel
        input   araddr,
        input   arvalid,
        output  arready,
        input   arprot,
        input   arid,
        input   arsubsysid,
        input   aridunq,
        input   aruser,
        input   artrace,

        // R channel
        output  rdata,
        output  rresp,
        output  rvalid,
        input   rready,
        output  rid,
        output  ridunq,
        output  ruser,
        output  rtrace,
        output  rpoison
    );

endinterface: axi_lite
