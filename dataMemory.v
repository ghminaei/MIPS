`timescale 1ps/1ps
module DataMemory (
    address,
    writeData,
    readData,
    memWrite,
    memRead
    );
    parameter WORD = 16, LENGTH = 1024, ADDRESSL = 10;
    input [ADDRESSL-1:0]address;
    input [WORD-1:0]writeData;
    input memWrite,
    memRead;
    output reg [WORD-1:0]readData;
    reg [WORD-1:0]memory[LENGTH-1:0];

    integer i;
    reg [WORD-1:0]allData[2*LENGTH-1:0];
    initial begin
        $readmemb("datas.txt", allData);
        readData <= 0;
        for (i = 0; i < LENGTH; i = i + 1) begin
            memory[i] = 0;
        end
        for (i = 0; i < 2*LENGTH; i = i + 1) begin
            memory[allData[i][9:0]] = allData[i+1];
            i=i+1;
        end
    end

    always @(*) begin
        if (memRead)
            readData <= memory[address];
        if (memWrite)
            memory[address] <= writeData;
    end
                      
endmodule
