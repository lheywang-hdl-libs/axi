/**
 * @file    axi.sv
 * @brief   Define the standard AXI signals as an interface file.
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

interface axi #(

    parameter int                                   ADDR_WIDTH = 32,
    parameter int                                   DATA_WIDTH = 32,
    parameter int                                   PAS_WIDTH = 0,
    parameter int                                   NUM_RP_AWW = 0,
    parameter int                                   ID_W_WIDTH = 0,
    parameter int                                   USER_REQ_WIDTH = 0,
    parameter int                                   AWSNOOP_WIDTH = 0,
    parameter int                                   LOOP_W_WIDTH = 0,
    parameter int                                   SECSID_WIDTH = 0,
    parameter int                                   SID_WIDTH = 0,
    parameter int                                   SSID_WIDTH = 0,
    parameter int                                   MECID_WIDTH = 0,
    parameter int                                   SUBSYSID_WIDTH = 0,
    parameter int                                   MPAM_WIDTH = 0,
    parameter int                                   AWCMO_WIDTH = 0,
    parameter int                                   ACT_W_WIDTH = 0,
    parameter int                                   BRESP_WIDTH = 1
);

    // =============================
    // AW CHANNEL (ADDR)
    // =============================
    logic                                           awvalid;
    logic                                           awready;
    logic                                           awpending;
    logic [NUM_RP_AWW : 0]                          awcrdt;
    logic                                           awcrdtsh;
    logic [$clog2(NUM_RP_AWW) : 0]                  awrp;
    logic                                           awsharedcrd;
    logic [ID_W_WIDTH : 0]                          awid;
    logic [ADDR_WIDTH - 1 : 0]                      awaddr;
    logic [3 : 0]                                   awregion;
    logic [7 : 0]                                   awlen;
    logic [2 : 0]                                   awsize;
    logic [1 : 0]                                   awburst;
    logic                                           awlock;
    logic [3 : 0]                                   awcache;
    logic [2 : 0]                                   awprot;
    logic                                           awnse;
    logic [PAS_WIDTH : 0]                           awpas;
    logic                                           awinst;
    logic                                           awpriv;
    logic [3 : 0]                                   awqos;
    logic [USER_REQ_WIDTH : 0]                      awuser;
    logic [1 : 0]                                   awdomain;
    logic [AWSNOOP_WIDTH : 0]                       awsnoop;
    logic [10 : 0]                                  awstashnid;
    logic                                           awstashniden;
    logic [4 : 0]                                   awstashlpid;
    logic                                           awstashlpiden;
    logic                                           awtrace;
    logic [LOOP_W_WIDTH : 0]                        awloop;
    logic                                           awmmuvalid;
    logic [SECSID_WIDTH : 0]                        awmmusecsid;
    logic [SID_WIDTH : 0]                           awmmusid;
    logic                                           awmmusiddv;
    logic [SSID_WIDTH : 0]                          awmmussid;
    logic                                           awmmuatst;
    logic [1 : 0]                                   awmmuflow;
    logic                                           awmmupasunknown;
    logic                                           awmmupm;
    logic [3 : 0]                                   awpbha;
    logic [MECID_WIDTH : 0]                         awmecid;
    logic [3 : 0]                                   awnsaid;
    logic [SUBSYSID_WIDTH : 0]                      awsubsysid;
    logic [5 : 0]                                   awatop;
    logic [MPAM_WIDTH : 0]                          awmpam;
    logic                                           awidunq;
    logic [AWCMO_WIDTH : 0]                         awcmo;
    logic [1 : 0]                                   awtagop;
    logic [ACT_W_WIDTH : 0]                         awact;
    logic                                           awactv;

    // =============================
    // W CHANNEL (DATA)
    // =============================
    logic                                           wvalid;
    logic                                           wready;
    logic                                           wpending;
    logic [NUM_RP_AWW : 0]                          wcrdt;
    logic                                           wcrdtsh;
    logic [$clog2(NUM_RP_AWW) : 0]                  wrp;
    logic                                           wsharedcrd;
    logic [DATA_WIDTH - 1 : 0]                      wdata;
    logic [(DATA_WIDTH / 8) - 1 : 0]                wstrb;
    logic [((DATA_WIDTH + 127) / 128) * 4 - 1 : 0]  wtag;
    logic [((DATA_WIDTH + 127) / 128) - 1 : 0]      wtagupdate;
    logic                                           wlast;
    logic [USER_DATA_WIDTH : 0]                     wuser;
    logic [((DATA_WIDTH + 63) / 64) - 1 : 0]        wpoison;
    logic                                           wtrace;

    // =============================
    // B CHANNEL (RESPONSE)
    // =============================
    logic                                           bvalid;
    logic                                           bready;
    logic                                           bpending;
    logic                                           bcrdt;
    logic [ID_W_WIDTH : 0]                          bid;
    logic                                           bidunq;
    logic [BRESP_WIDTH : 0]                         bresp;
    logic                                           bcomp;
    logic                                           bpersist;
    logic [1 : 0]                                   btagmatch;
    logic [USER_RESP_WIDTH : 0]                     buser;
    logic                                           btrace;
    logic [LOOP_W_WIDTH : 0]                        bloop;
    logic [1 : 0]                                   bbusy;

    // =============================
    // AR CHANNEL (ADDR)
    // =============================
    logic                                           arvalid;
    logic                                           arready;
    logic                                           arpending;
    logic [NUM_RP_AWW : 0]                          arcrdt;
    logic                                           arcrdtsh;
    logic [$clog2(NUM_RP_AWW) : 0]                  arrp;
    logic                                           arsharedcrd;
    logic [ID_W_WIDTH : 0]                          arid;
    logic [ADDR_WIDTH - 1 : 0]                      araddr;
    logic [3 : 0]                                   arregion;
    logic [7 : 0]                                   arlen;
    logic [2 : 0]                                   arsize;
    logic [1 : 0]                                   arburst;
    logic                                           arlock;
    logic [3 : 0]                                   arcache;
    logic [2 : 0]                                   arprot;
    logic                                           arnse;
    logic [PAS_WIDTH : 0]                           arpas;
    logic                                           arinst;
    logic                                           arpriv;
    logic [3 : 0]                                   arqos;
    logic [USER_REQ_WIDTH : 0]                      aruser;
    logic [1 : 0]                                   ardomain;
    logic [AWSNOOP_WIDTH : 0]                       arsnoop;
    logic [10 : 0]                                  arstashnid;
    logic                                           arstashniden;
    logic [4 : 0]                                   arstashlpid;
    logic                                           arstashlpiden;
    logic                                           artrace;
    logic [LOOP_W_WIDTH : 0]                        arloop;
    logic                                           armmuvalid;
    logic [SECSID_WIDTH : 0]                        armmusecsid;
    logic [SID_WIDTH : 0]                           armmusid;
    logic                                           armmusiddv;
    logic [SSID_WIDTH : 0]                          armmussid;
    logic                                           armmuatst;
    logic [1 : 0]                                   armmuflow;
    logic                                           armmupasunknown;
    logic                                           armmupm;
    logic [3 : 0]                                   arpbha;
    logic [MECID_WIDTH : 0]                         armecid;
    logic [3 : 0]                                   arnsaid;
    logic [SUBSYSID_WIDTH : 0]                      arsubsysid;
    logic [5 : 0]                                   aratop;
    logic [MPAM_WIDTH : 0]                          armpam;
    logic                                           aridunq;
    logic [AWCMO_WIDTH : 0]                         arcmo;
    logic [1 : 0]                                   artagop;
    logic [ACT_W_WIDTH : 0]                         aract;
    logic                                           aractv;

    // =============================
    // R CHANNEL (DATA)
    // =============================
    logic                                           rvalid;
    logic                                           rready;
    logic                                           rpending;
    logic                                           rcrdt;
    logic [ID_W_WIDTH : 0]                          rid;
    logic                                           ridunq;
    logic [BRESP_WIDTH : 0]                         rresp;
    logic                                           rcomp;
    logic                                           rpersist;
    logic [1 : 0]                                   rtagmatch;
    logic [USER_RESP_WIDTH : 0]                     ruser;
    logic                                           rtrace;
    logic [LOOP_W_WIDTH : 0]                        rloop;
    logic [1 : 0]                                   rbusy;

    // =============================
    // MASTER
    // =============================
    modport master (
        // =============================
        // AW CHANNEL (ADDR)
        // =============================
        output  awvalid,
        input   awready,
        output  awpending,
        input   awcrdt,
        input   awcrdtsh,
        output  awrp,
        output  awsharedcrd,
        output  awid,
        output  awaddr,
        output  awregion,
        output  awlen,
        output  awsize,
        output  awburst,
        output  awlock,
        output  awcache,
        output  awprot,
        output  awnse,
        output  awpas,
        output  awinst,
        output  awpriv,
        output  awqos,
        output  awuser,
        output  awdomain,
        output  awsnoop,
        output  awstashnid,
        output  awstashniden,
        output  awstashlpid,
        output  awstashlpiden,
        output  awtrace,
        output  awloop,
        output  awmmuvalid,
        output  awmmusecsid,
        output  awmmusid,
        output  awmmusiddv,
        output  awmmussid,
        output  awmmuatst,
        output  awmmuflow,
        output  awmmupasunknown,
        output  awmmupm,
        output  awpbha,
        output  awmecid,
        output  awnsaid,
        output  awsubsysid,
        output  awatop,
        output  awmpam,
        output  awidunq,
        output  awcmo,
        output  awtagop,
        output  awact,
        output  awactv,

        // =============================
        // W CHANNEL (DATA)
        // =============================
        output  wvalid,
        input   wready,
        output  wpending,
        input   wcrdt,
        input   wcrdtsh,
        output  wrp,
        output  wsharedcrd,
        output  wdata,
        output  wstrb,
        output  wtag,
        output  wtagupdate,
        output  wlast,
        output  wuser,
        output  wpoison,
        output  wtrace,

        // =============================
        // B CHANNEL (RESPONSE)
        // =============================
        input   bvalid,
        output  bready,
        input   bpending,
        output  bcrdt,
        input   bid,
        input   bidunq,
        input   bresp,
        input   bcomp,
        input   bpersist,
        input   btagmatch,
        input   buser,
        input   btrace,
        input   bloop,
        input   bbusy,

        // =============================
        // AR CHANNEL (ADDR)
        // =============================
        output  arvalid,
        input   arready,
        output  arpending,
        input   arcrdt,
        input   arcrdtsh,
        output  arrp,
        output  arsharedcrd,
        output  arid,
        output  araddr,
        output  arregion,
        output  arlen,
        output  arsize,
        output  arburst,
        output  arlock,
        output  arcache,
        output  arprot,
        output  arnse,
        output  arpas,
        output  arinst,
        output  arpriv,
        output  arqos,
        output  aruser,
        output  ardomain,
        output  arsnoop,
        output  arstashnid,
        output  arstashniden,
        output  arstashlpid,
        output  arstashlpiden,
        output  artrace,
        output  arloop,
        output  armmuvalid,
        output  armmusecsid,
        output  armmusid,
        output  armmusiddv,
        output  armmussid,
        output  armmuatst,
        output  armmuflow,
        output  armmupasunknown,
        output  armmupm,
        output  arpbha,
        output  armecid,
        output  arnsaid,
        output  arsubsysid,
        output  aratop,
        output  armpam,
        output  aridunq,
        output  arcmo,
        output  artagop,
        output  aract,
        output  aractv,

        // =============================
        // R CHANNEL (DATA)
        // =============================
        input   rvalid,
        output  rready,
        input   rpending,
        output  rcrdt,
        input   rid,
        input   ridunq,
        input   rresp,
        input   rcomp,
        input   rpersist,
        input   rtagmatch,
        input   ruser,
        input   rtrace,
        input   rloop,
        input   rbusy
    );

    // =============================
    // CLIENT
    // =============================
    modport client (
        // =============================
        // AW CHANNEL (ADDR)
        // =============================
        input   awvalid,
        output  awready,
        input   awpending,
        output  awcrdt,
        output  awcrdtsh,
        input   awrp,
        input   awsharedcrd,
        input   awid,
        input   awaddr,
        input   awregion,
        input   awlen,
        input   awsize,
        input   awburst,
        input   awlock,
        input   awcache,
        input   awprot,
        input   awnse,
        input   awpas,
        input   awinst,
        input   awpriv,
        input   awqos,
        input   awuser,
        input   awdomain,
        input   awsnoop,
        input   awstashnid,
        input   awstashniden,
        input   awstashlpid,
        input   awstashlpiden,
        input   awtrace,
        input   awloop,
        input   awmmuvalid,
        input   awmmusecsid,
        input   awmmusid,
        input   awmmusiddv,
        input   awmmussid,
        input   awmmuatst,
        input   awmmuflow,
        input   awmmupasunknown,
        input   awmmupm,
        input   awpbha,
        input   awmecid,
        input   awnsaid,
        input   awsubsysid,
        input   awatop,
        input   awmpam,
        input   awidunq,
        input   awcmo,
        input   awtagop,
        input   awact,
        input   awactv,

        // =============================
        // W CHANNEL (DATA)
        // =============================
        input   wvalid,
        output  wready,
        input   wpending,
        output  wcrdt,
        output  wcrdtsh,
        input   wrp,
        input   wsharedcrd,
        input   wdata,
        input   wstrb,
        input   wtag,
        input   wtagupdate,
        input   wlast,
        input   wuser,
        input   wpoison,
        input   wtrace,

        // =============================
        // B CHANNEL (RESPONSE)
        // =============================
        output  bvalid,
        input   bready,
        output  bpending,
        input   bcrdt,
        output  bid,
        output  bidunq,
        output  bresp,
        output  bcomp,
        output  bpersist,
        output  btagmatch,
        output  buser,
        output  btrace,
        output  bloop,
        output  bbusy,

        // =============================
        // AR CHANNEL (ADDR)
        // =============================
        input   arvalid,
        output  arready,
        input   arpending,
        output  arcrdt,
        output  arcrdtsh,
        input   arrp,
        input   arsharedcrd,
        input   arid,
        input   araddr,
        input   arregion,
        input   arlen,
        input   arsize,
        input   arburst,
        input   arlock,
        input   arcache,
        input   arprot,
        input   arnse,
        input   arpas,
        input   arinst,
        input   arpriv,
        input   arqos,
        input   aruser,
        input   ardomain,
        input   arsnoop,
        input   arstashnid,
        input   arstashniden,
        input   arstashlpid,
        input   arstashlpiden,
        input   artrace,
        input   arloop,
        input   armmuvalid,
        input   armmusecsid,
        input   armmusid,
        input   armmusiddv,
        input   armmussid,
        input   armmuatst,
        input   armmuflow,
        input   armmupasunknown,
        input   armmupm,
        input   arpbha,
        input   armecid,
        input   arnsaid,
        input   arsubsysid,
        input   aratop,
        input   armpam,
        input   aridunq,
        input   arcmo,
        input   artagop,
        input   aract,
        input   aractv,

        // =============================
        // R CHANNEL (DATA)
        // =============================
        output  rvalid,
        input   rready,
        output  rpending,
        input   rcrdt,
        output  rid,
        output  ridunq,
        output  rresp,
        output  rcomp,
        output  rpersist,
        output  rtagmatch,
        output  ruser,
        output  rtrace,
        output  rloop,
        output  rbusy
    );

endinterface: axi
