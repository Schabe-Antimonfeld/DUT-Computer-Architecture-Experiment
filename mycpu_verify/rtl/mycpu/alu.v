module alu(
    input [14:0] op,
    input [31:0] src1,
    input [31:0] src2,
    output[31:0] result
);

wire[31:0] srai_result;

assign srai_result = $signed(src1) >>> src2[4:0];

assign result =
    op[14] ? src1 + src2 :                              // add_w
    op[13] ? src1 + src2 :                              // addi_w
    op[12] ? src1 + src2 :                              // ld_w
    op[11] ? src1 + src2 :                              // st_w
    op[10] ? src1 - src2 :                              // sub_w
    op[ 9] ? {31'b0, ($signed(src1) < $signed(src2))} : // slt
    op[ 8] ? {31'b0, (src1 < src2)} :                   // sltu
    op[ 7] ? src1 << src2[4:0] :                        // slli_w
    op[ 6] ? src1 >> src2[4:0] :                        // srli_w
    op[ 5] ? srai_result :                              // srai_w
    op[ 4] ? src1 & src2 :                              // and_w
    op[ 3] ? src1 | src2 :                              // or_w
    op[ 2] ? ~(src1 | src2) :                           // nor_w
    op[ 1] ? src1 ^ src2 :                              // xor_w
    op[ 0] ? src2 :                                     // mov_w
    32'b0;


endmodule