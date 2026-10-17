module alu(
    input [14:0] op,
    input [31:0] src1,
    input [31:0] src2,
    output[31:0] result
);

wire[31:0] srai_result;

assign srai_result = $signed(src1) >>> src2[4:0];

assign result =
    op[14] ? src1 + src2 :
    op[13] ? src1 + src2 :
    op[12] ? src1 + src2 :
    op[11] ? src1 + src2 :
    op[10] ? src1 - src2 :
    op[ 9] ? {31'b0, ($signed(src1) < $signed(src2))} :
    op[ 8] ? {31'b0, (src1 < src2)} :
    op[ 7] ? src1 << src2[4:0] :
    op[ 6] ? src1 >> src2[4:0] :
    op[ 5] ? srai_result :
    op[ 4] ? src1 & src2 :
    op[ 3] ? src1 | src2 :
    op[ 2] ? ~(src1 | src2) :
    op[ 1] ? src1 ^ src2 :
    op[ 0] ? src2 :
    32'b0;


endmodule