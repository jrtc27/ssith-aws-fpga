
import Connectable :: *;

// Bluestuff AXI4
import AXI4_Types :: *;
import Bluespec_AXI4_Types :: *;

instance Connectable #(AXI4_Master_IFC #(wd_id, wd_addr, wd_data, wd_user),
                       AXI4_Slave_Synth  #(wd_id, wd_addr, wd_data, wd_user, wd_user, wd_user, wd_user, wd_user));

   module mkConnection #(AXI4_Master_IFC #(wd_id, wd_addr, wd_data, wd_user) axim,
                         AXI4_Slave_Synth  #(wd_id, wd_addr, wd_data, wd_user, wd_user, wd_user, wd_user, wd_user) axis)
                       (Empty);

      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_wr_addr_channel if (axim.m_awvalid);
         axis.aw.awflit (axim.m_awid,
                         axim.m_awaddr,
                         axim.m_awlen,
                         unpack(pack(axim.m_awsize)),
                         unpack(pack(axim.m_awburst)),
                         unpack(pack(axim.m_awlock)),
                         axim.m_awcache,
                         axim.m_awprot,
                         axim.m_awqos,
                         axim.m_awregion,
                         axim.m_awuser);
      endrule
      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_aw_ready_channel;
         axim.m_awready (axis.aw.awready);
      endrule

      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_wr_data_channel if (axim.m_wvalid);
         axis.w.wflit ( axim.m_wdata,
                        axim.m_wstrb,
                        axim.m_wlast,
                        axim.m_wuser);
      endrule
      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_w_ready_channel;
         axim.m_wready (axis.w.wready);
      endrule

      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_wr_response_channel;
         axim.m_bvalid (axis.b.bvalid,
                        axis.b.bid,
                        unpack(pack(axis.b.bresp)),
                        axis.b.buser);
      endrule
      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_b_ready_channel;
         axis.b.bready (axim.m_bready);
      endrule

      rule rl_rd_addr_channel if (axim.m_arvalid);
         axis.ar.arflit (axim.m_arid,
                          axim.m_araddr,
                          axim.m_arlen,
                          unpack(pack(axim.m_arsize)),
                          unpack(pack(axim.m_arburst)),
                          unpack(pack(axim.m_arlock)),
                          axim.m_arcache,
                          axim.m_arprot,
                          axim.m_arqos,
                          axim.m_arregion,
                          axim.m_aruser);
      endrule
      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_ar_ready_channel;
         axim.m_arready (axis.ar.arready);
      endrule

      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_rd_data_channel;
         axim.m_rvalid (axis.r.rvalid,
                        axis.r.rid,
                        axis.r.rdata,
                        unpack(pack(axis.r.rresp)),
                        axis.r.rlast,
                        axis.r.ruser);
      endrule
      rule rl_r_ready_channel;
         axis.r.rready (axim.m_rready);
      endrule
   endmodule
endinstance


instance Connectable #(AXI4_Master_Synth #(wd_id, wd_addr, wd_data, wd_user, wd_user, wd_user, wd_user, wd_user),
                       AXI4_Slave_IFC  #(wd_id, wd_addr, wd_data, wd_user));

   module mkConnection #(AXI4_Master_Synth #(wd_id, wd_addr, wd_data, wd_user, wd_user, wd_user, wd_user, wd_user) axim,
                         AXI4_Slave_IFC  #(wd_id, wd_addr, wd_data, wd_user) axis)
                       (Empty);
   rule connect_awflit;
      axis.m_awvalid(axim.aw.awvalid,
                     axim.aw.awid,
                     axim.aw.awaddr,
                     axim.aw.awlen,
                     unpack(pack(axim.aw.awsize)),
                     unpack(pack(axim.aw.awburst)),
                     unpack(pack(axim.aw.awlock)),
                     axim.aw.awcache,
                     axim.aw.awprot,
                     axim.aw.awqos,
                     axim.aw.awregion,
                     axim.aw.awuser);
    endrule
    rule connect_awready; axim.aw.awready(axis.m_awready); endrule

    rule connect_wflit;
       axis.m_wvalid(axim.w.wvalid, axim.w.wdata, axim.w.wstrb, axim.w.wlast, axim.w.wuser);
    endrule
    rule connect_wready; axim.w.wready(axis.m_wready); endrule

    rule connect_bflit if (axis.m_bvalid);
       axim.b.bflit(axis.m_bid, unpack(pack(axis.m_bresp)), axis.m_buser);
    endrule
    rule connect_bready; axis.m_bready(axim.b.bready); endrule

   rule connect_arflit;
      axis.m_arvalid(axim.ar.arvalid,
                     axim.ar.arid,
                     axim.ar.araddr,
                     axim.ar.arlen,
                     unpack(pack(axim.ar.arsize)),
                     unpack(pack(axim.ar.arburst)),
                     unpack(pack(axim.ar.arlock)),
                     axim.ar.arcache,
                     axim.ar.arprot,
                     axim.ar.arqos,
                     axim.ar.arregion,
                     axim.ar.aruser);
    endrule
    rule connect_arready; axim.ar.arready(axis.m_arready); endrule

    rule connect_rflit if (axis.m_rvalid);
      axim.r.rflit(axis.m_rid, axis.m_rdata, unpack(pack(axis.m_rresp)), axis.m_rlast, axis.m_ruser);
    endrule
    rule connect_rready; axis.m_rready(axim.r.rready); endrule

   endmodule
endinstance
