/*******************************************************************
 * @file     custom_ddr.h is generated by ddrmctl2_PAIS_Tool
 * @version  v3.11
 * @date     2023/10/31 �W�� 09:21:25
 * @brief    DDR settings header file
 *
 * SPDX-License-Identifier: BSD-3-Clause
 * Copyright (C) 2023 Nuvoton Technology Corp. All rights reserved.
********************************************************************/

/**************************Chip system parameters*******************
Frequency of APB interface clock of DDR memory controller.......90
DDR DRAM types..................................................DDR3
DDR Data Rate...................................................1066
DRAM size per device............................................256
Number of ranks that system chip connects to used DRAM..........1
Bit number of bank address for used DRAM........................3
Bit number of row address for used DRAM.........................14
Bit number of column address for used DRAM......................10
Output driver impedance for used DDR3...........................34
ODT(On Die Termination) for used DDR3...........................60
Output driver impedance for DDR3 PHY............................34
ODT(On Die Termination) for DDR3 PHY............................60
Write leveling training function (only for DDR3 DRAM)...........Disable
********************************************************************/

/**************************DRAM timing parameters*******************
            tCK        ns     Final
CL:           8         -         8
CWL:          6         -         6
tRCD:         -      13.5         7
tRP:          -      13.5         7
tRC:          -      49.5        26
tRAS_max:     -     26280     14007
tRAS_min:     -        36        19
tDLLK:      512         -       512
tRTP:         4       7.5         4
tWTR:         4       7.5         4
tWR:          -        15         8
tMRD:         4         -         4
tMOD:        12        15        12
tCCD:         4         -         4
tRRD:         4       7.5         4
tFAW:         -        45        24
tZQinit:    512       640       512
tZQoper:    256       320       256
tZQCS:       64        80        64
tXS:          5       170        91
tXSDLL:     512         -       512
tCKSRE:       5        10         5
tCKSRX:       5        10         5
tRFC:         -       160        85
tREFI:        -      2920      1556
tXP:          3         6         3
tXPDLL:      10        24        13
tCKE:         3     5.625         3
tWLMRD:      40         -        40
tWLO:         -         9         5
********************************************************************/

#ifndef __NVT_DDR_INIT_PARAM_H__
#define __NVT_DDR_INIT_PARAM_H__


struct nvt_ddr_init_param custom_ddr= {
       0x00000001,  //DBG1
       0x00000001,  //PWRCTL
       0x01040001,  //MSTR
       0x0000D010,  //MRCTRL0
       0x00000000,  //MRCTRL1
       0x00000000,  //PWRCTL
       0x00400010,  //PWRTMG
       0x000A0003,  //HWLPCTL
       0x00210000,  //RFSHCTL0
       0x003C003C,  //RFSHCTL1
       0x00000000,  //RFSHCTL3
       0x0017002C,  //RFSHTMG
       0x00000000,  //CRCPARCTL0
       0x40020083,  //INIT0
       0x00350002,  //INIT1
       0x19400006,  //INIT3
       0x00480000,  //INIT4
       0x00090000,  //INIT5
       0x00000000,  //DIMMCTL
       0x0000032F,  //RANKCTL
       0x0A0D050B,  //DRAMTMG0
       0x0003030F,  //DRAMTMG1
       0x00000508,  //DRAMTMG2
       0x00003007,  //DRAMTMG3
       0x05030305,  //DRAMTMG4
       0x04040303,  //DRAMTMG5
       0x00000903,  //DRAMTMG8
       0x80000033,  //DRAMTMG15
       0x00810021,  //ZQCTL0
       0x00000100,  //ZQCTL1
       0x04020101,  //DFITMG0
       0x00060101,  //DFITMG1
       0x0700B030,  //DFILPCFG0
       0x00400005,  //DFIUPD0
       0x00170066,  //DFIUPD1
       0x80000000,  //DFIUPD2
       0x00000011,  //DFIMISC
       0x00000000,  //DFIPHYMSTR
       0x0000001F,  //ADDRMAP0
       0x00080808,  //ADDRMAP1
       0x00000000,  //ADDRMAP2
       0x00000000,  //ADDRMAP3
       0x00001F1F,  //ADDRMAP4
       0x070F0707,  //ADDRMAP5
       0x0F0F0707,  //ADDRMAP6
       0x07070707,  //ADDRMAP9
       0x07070707,  //ADDRMAP10
       0x00000007,  //ADDRMAP11
       0x06000608,  //ODTCFG
       0x00000101,  //ODTMAP
       0x00F51F00,  //SCHED
       0x00000000,  //SCHED1
       0x0F000001,  //PERFHPR1
       0x0F00007F,  //PERFLPR1
       0x0F00007F,  //PERFWR1
       0x00000000,  //DBG0
       0x00000000,  //DBG1
       0x00000000,  //DBGCMD
       0x00000001,  //SWCTL
       0x00000000,  //SWCTLSTATIC
       0x00110011,  //POISONCFG
       0x00000001,  //PCTRL_0
       0x00000000,  //PCTRL_1
       0x00000000,  //PCTRL_2
       0x00000000,  //PCTRL_3
       0x00000000,  //PCTRL_4
       0x00000001,  //PCTRL_5
       0x00000001,  //PCTRL_6
       0x00000000,  //PCCFG
       0x0001500F,  //PCFGR_0
       0x0001500F,  //PCFGR_1
       0x0001500F,  //PCFGR_2
       0x0001500F,  //PCFGR_3
       0x0001500F,  //PCFGR_4
       0x0001500F,  //PCFGR_5
       0x0001500F,  //PCFGR_6
       0x0000500F,  //PCFGW_0
       0x0000500F,  //PCFGW_1
       0x0000500F,  //PCFGW_2
       0x0000500F,  //PCFGW_3
       0x0000500F,  //PCFGW_4
       0x0000500F,  //PCFGW_5
       0x0000500F,  //PCFGW_6
       0x00000008,  //SARBASE0
       0x00000000,  //SARSIZE0
       0xF004649F,  //DSGCR
       0x0300C461,  //PGCR1
       0x00F00484,  //PGCR2
       0x0B405A03,  //PTR0
       0x2328032B,  //PTR1
       0x00083DEF,  //PTR2
       0x05C41105,  //PTR3
       0x0801A069,  //PTR4
       0x00001940,  //MR0_DDR3
       0x00000006,  //MR1_DDR3
       0x00000048,  //MR2_DDR3
       0x00000000,  //MR3_DDR3
       0x71559955,  //DTPR0
       0x2292BB25,  //DTPR1
       0x30023A01,  //DTPR2
       0x0000105D,  //ZQ0CR1
       0x0000040B,  //DCR
       0x91003587,  //DTCR
       0x0001C000,  //PLLCR
       0x0000F581,  //PIR
       0x00000000,  //SWCTL
       0x0000000B,  //PWRCTL
       0x00000001,  //SWCTL
};


#endif