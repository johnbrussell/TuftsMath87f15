zmarkup = [.4 .3 .3];
zsell = [3.69 .6 2.02];
zdemand = [29 64 28];
zstorage_space = -1;
zwait_time = [7 7 7];
zlifespan = [7 14 21];
zn = 300;


zmarkup = [.1 .1 .1];
zlifespan = [1 2 3];
%zstorage_space = 11;
aprofit = [0 0 0];
alost_cust = [0 0 0];
aspaced_out = [0 0 0];
aperished = [0 0 0];
atargets = [0 0 0];
asold = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl, zsoldl] = perishablenonfifo(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    aprofit = aprofit + zprofitl/zn/49;
    alost_cust = alost_cust + zlost_custl/zn/49;
    aspaced_out = aspaced_out + zspaced_outl/zn/49;
    aperished = aperished + zperishedl/zn/49;
    atargets = atargets + ztargetsl/zn;
    asold = asold + zsoldl/zn/49;
end