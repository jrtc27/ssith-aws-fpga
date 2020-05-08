import AWS_AXI4_Types :: *;
import Connectable :: *;

import AXI4_Types :: *;

instance Connectable #(AXI4_Types::AXI4_Master_IFC    #(m_wd_id, wd_addr, wd_data, wd_user),
		       AWS_AXI4_Types::AXI4_Slave_IFC #(s_wd_id, wd_addr, wd_data, wd_user))
   provisos (Add #(a__, m_wd_id, s_wd_id));

   module mkConnection #(AXI4_Types::AXI4_Master_IFC     #(m_wd_id, wd_addr, wd_data, wd_user) axim,
			 AWS_AXI4_Types::AXI4_Slave_IFC  #(s_wd_id, wd_addr, wd_data, wd_user) axis)
		       (Empty);

      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_wr_addr_channel;
	 axis.m_awvalid (axim.m_awvalid,
			 zeroExtend(axim.m_awid),
			 axim.m_awaddr,
			 axim.m_awlen,
			 axim.m_awsize,
			 axim.m_awburst,
			 axim.m_awlock,
			 axim.m_awcache,
			 axim.m_awprot,
			 axim.m_awqos,
			 axim.m_awregion,
			 axim.m_awuser);
	 axim.m_awready (axis.m_awready);
      endrule

      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_wr_data_channel;
	 axis.m_wvalid (axim.m_wvalid,
			axim.m_wdata,
			axim.m_wstrb,
			axim.m_wlast,
			axim.m_wuser);
	 axim.m_wready (axis.m_wready);
      endrule

      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_wr_response_channel;
	 axim.m_bvalid (axis.m_bvalid,
			truncate(axis.m_bid),
			axis.m_bresp,
			axis.m_buser);
	 axis.m_bready (axim.m_bready);
      endrule

      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_rd_addr_channel;
	 axis.m_arvalid (axim.m_arvalid,
			 zeroExtend(axim.m_arid),
			 axim.m_araddr,
			 axim.m_arlen,
			 axim.m_arsize,
			 axim.m_arburst,
			 axim.m_arlock,
			 axim.m_arcache,
			 axim.m_arprot,
			 axim.m_arqos,
			 axim.m_arregion,
			 axim.m_aruser);
	 axim.m_arready (axis.m_arready);
      endrule

      (* fire_when_enabled, no_implicit_conditions *)
      rule rl_rd_data_channel;
	 axim.m_rvalid (axis.m_rvalid,
			truncate(axis.m_rid),
			axis.m_rdata,
			axis.m_rresp,
			axis.m_rlast,
			axis.m_ruser);
	 axis.m_rready (axim.m_rready);
      endrule
   endmodule
endinstance