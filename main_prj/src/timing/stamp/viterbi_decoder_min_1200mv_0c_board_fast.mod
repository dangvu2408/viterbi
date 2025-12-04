/*
 Copyright (C) 2025  Altera Corporation. All rights reserved.
 Your use of Altera Corporation's design tools, logic functions 
 and other software and tools, and any partner logic 
 functions, and any output files from any of the foregoing 
 (including device programming or simulation files), and any 
 associated documentation or information are expressly subject 
 to the terms and conditions of the Altera Program License 
 Subscription Agreement, the Altera Quartus Prime License Agreement,
 the Altera IP License Agreement, or other applicable license
 agreement, including, without limitation, that your use is for
 the sole purpose of programming logic devices manufactured by
 Altera and sold by Altera or its authorized distributors.  Please
 refer to the Altera Software License Subscription Agreements 
 on the Quartus Prime software download page.
*/
MODEL
/*MODEL HEADER*/
/*
 This file contains Fast Corner delays for the design using part EP4CE115F29C7
 with speed grade M, core voltage 1.2V, and temperature 0 Celsius

*/
MODEL_VERSION "1.0";
DESIGN "viterbi_decoder";
DATE "11/26/2025 18:59:21";
PROGRAM "Quartus Prime";



INPUT en;
INPUT rst;
INPUT clk;
INPUT data[10];
INPUT data[8];
INPUT data[12];
INPUT data[14];
INPUT data[0];
INPUT data[4];
INPUT data[6];
INPUT data[2];
INPUT data[15];
INPUT data[11];
INPUT data[9];
INPUT data[13];
INPUT data[3];
INPUT data[1];
INPUT data[7];
INPUT data[5];
OUTPUT data_out[0];
OUTPUT data_out[1];
OUTPUT data_out[2];
OUTPUT data_out[3];
OUTPUT data_out[4];
OUTPUT data_out[5];
OUTPUT data_out[6];
OUTPUT data_out[7];
OUTPUT done_flag;

/*Arc definitions start here*/
pos_data[0]__clk__setup:		SETUP (POSEDGE) data[0] clk ;
pos_data[1]__clk__setup:		SETUP (POSEDGE) data[1] clk ;
pos_data[2]__clk__setup:		SETUP (POSEDGE) data[2] clk ;
pos_data[3]__clk__setup:		SETUP (POSEDGE) data[3] clk ;
pos_data[4]__clk__setup:		SETUP (POSEDGE) data[4] clk ;
pos_data[5]__clk__setup:		SETUP (POSEDGE) data[5] clk ;
pos_data[6]__clk__setup:		SETUP (POSEDGE) data[6] clk ;
pos_data[7]__clk__setup:		SETUP (POSEDGE) data[7] clk ;
pos_data[8]__clk__setup:		SETUP (POSEDGE) data[8] clk ;
pos_data[9]__clk__setup:		SETUP (POSEDGE) data[9] clk ;
pos_data[10]__clk__setup:		SETUP (POSEDGE) data[10] clk ;
pos_data[11]__clk__setup:		SETUP (POSEDGE) data[11] clk ;
pos_data[12]__clk__setup:		SETUP (POSEDGE) data[12] clk ;
pos_data[13]__clk__setup:		SETUP (POSEDGE) data[13] clk ;
pos_data[14]__clk__setup:		SETUP (POSEDGE) data[14] clk ;
pos_data[15]__clk__setup:		SETUP (POSEDGE) data[15] clk ;
pos_en__clk__setup:		SETUP (POSEDGE) en clk ;
pos_rst__clk__setup:		SETUP (POSEDGE) rst clk ;
pos_data[0]__clk__hold:		HOLD (POSEDGE) data[0] clk ;
pos_data[1]__clk__hold:		HOLD (POSEDGE) data[1] clk ;
pos_data[2]__clk__hold:		HOLD (POSEDGE) data[2] clk ;
pos_data[3]__clk__hold:		HOLD (POSEDGE) data[3] clk ;
pos_data[4]__clk__hold:		HOLD (POSEDGE) data[4] clk ;
pos_data[5]__clk__hold:		HOLD (POSEDGE) data[5] clk ;
pos_data[6]__clk__hold:		HOLD (POSEDGE) data[6] clk ;
pos_data[7]__clk__hold:		HOLD (POSEDGE) data[7] clk ;
pos_data[8]__clk__hold:		HOLD (POSEDGE) data[8] clk ;
pos_data[9]__clk__hold:		HOLD (POSEDGE) data[9] clk ;
pos_data[10]__clk__hold:		HOLD (POSEDGE) data[10] clk ;
pos_data[11]__clk__hold:		HOLD (POSEDGE) data[11] clk ;
pos_data[12]__clk__hold:		HOLD (POSEDGE) data[12] clk ;
pos_data[13]__clk__hold:		HOLD (POSEDGE) data[13] clk ;
pos_data[14]__clk__hold:		HOLD (POSEDGE) data[14] clk ;
pos_data[15]__clk__hold:		HOLD (POSEDGE) data[15] clk ;
pos_en__clk__hold:		HOLD (POSEDGE) en clk ;
pos_rst__clk__hold:		HOLD (POSEDGE) rst clk ;
pos_clk__data_out[0]__delay:		DELAY (POSEDGE) clk data_out[0] ;
pos_clk__data_out[1]__delay:		DELAY (POSEDGE) clk data_out[1] ;
pos_clk__data_out[2]__delay:		DELAY (POSEDGE) clk data_out[2] ;
pos_clk__data_out[3]__delay:		DELAY (POSEDGE) clk data_out[3] ;
pos_clk__data_out[4]__delay:		DELAY (POSEDGE) clk data_out[4] ;
pos_clk__data_out[5]__delay:		DELAY (POSEDGE) clk data_out[5] ;
pos_clk__data_out[6]__delay:		DELAY (POSEDGE) clk data_out[6] ;
pos_clk__data_out[7]__delay:		DELAY (POSEDGE) clk data_out[7] ;
pos_clk__done_flag__delay:		DELAY (POSEDGE) clk done_flag ;

ENDMODEL
