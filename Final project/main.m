zmarkup = [.4 .3 .3];
zsell = [3.69 .6 2.02];
zdemand = [29 64 28];
zstorage_space = -1;
zwait_time = [7 7 7];
zlifespan = [7 14 21];
zn = 300;

%1. regular markup, unconstrained storage space, 1 week from order to
%delivery of goods, non-perishability, goods sold FIFO
aprofit = [0 0 0];
alost_cust = [0 0 0];
aspaced_out = [0 0 0];
aperished = [0 0 0];
atargets = [0 0 0];
asold = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl, zsoldl] = perishable(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    aprofit = aprofit + zprofitl/zn;
    alost_cust = alost_cust + zlost_custl/zn;
    aspaced_out = aspaced_out + zspaced_outl/zn;
    aperished = aperished + zperishedl/zn;
    atargets = atargets + ztargetsl/zn;
    asold = asold + zsoldl/zn;
end

%b Proportionally short shelf lives
zlifespan = [1 2 3];
bprofit = [0 0 0];
blost_cust = [0 0 0];
bspaced_out = [0 0 0];
bperished = [0 0 0];
btargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishable(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    bprofit = bprofit + zprofitl/zn;
    blost_cust = blost_cust + zlost_custl/zn;
    bspaced_out = bspaced_out + zspaced_outl/zn;
    bperished = bperished + zperishedl/zn;
    btargets = btargets + ztargetsl/zn;
end
zlifespan = [7 14 21];

%c Non-fifo
cprofit = [0 0 0];
clost_cust = [0 0 0];
cspaced_out = [0 0 0];
cperished = [0 0 0];
ctargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishablenonfifo(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    cprofit = cprofit + zprofitl/zn;
    clost_cust = clost_cust + zlost_custl/zn;
    cspaced_out = cspaced_out + zspaced_outl/zn;
    cperished = cperished + zperishedl/zn;
    ctargets = ctargets + ztargetsl/zn;
end

%d Constrained storage space: just 9 cubic feet despite demand for more
%than 11
zstorage_space = 9;
dprofit = [0 0 0];
dlost_cust = [0 0 0];
dspaced_out = [0 0 0];
dperished = [0 0 0];
dtargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishable(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    dprofit = dprofit + zprofitl/zn;
    dlost_cust = dlost_cust + zlost_custl/zn;
    dspaced_out = dspaced_out + zspaced_outl/zn;
    dperished = dperished + zperishedl/zn;
    dtargets = dtargets + ztargetsl/zn;
end
zstorage_space = -1;

%e Markup on goods only 10%
zmarkup = [.1 .1 .1];
eprofit = [0 0 0];
elost_cust = [0 0 0];
espaced_out = [0 0 0];
eperished = [0 0 0];
etargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishable(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    eprofit = eprofit + zprofitl/zn;
    elost_cust = elost_cust + zlost_custl/zn;
    espaced_out = espaced_out + zspaced_outl/zn;
    eperished = eperished + zperishedl/zn;
    etargets = etargets + ztargetsl/zn;
end
zmarkup = [.4 .3 .3];

%f Goods ship the day after they are ordered
zwait_time = [1 1 1];
fprofit = [0 0 0];
flost_cust = [0 0 0];
fspaced_out = [0 0 0];
fperished = [0 0 0];
ftargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishable(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    fprofit = fprofit + zprofitl/zn;
    flost_cust = flost_cust + zlost_custl/zn;
    fspaced_out = fspaced_out + zspaced_outl/zn;
    fperished = fperished + zperishedl/zn;
    ftargets = ftargets + ztargetsl/zn;
end
zwait_time = [7 7 7];

%abcdefg Yogurt ships the day after they are ordered
zwait_time = [7 1 7];
abcdefgprofit = [0 0 0];
abcdefglost_cust = [0 0 0];
abcdefgspaced_out = [0 0 0];
abcdefgperished = [0 0 0];
abcdefgtargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishable(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    abcdefgprofit = abcdefgprofit + zprofitl/zn;
    abcdefglost_cust = abcdefglost_cust + zlost_custl/zn;
    abcdefgspaced_out = abcdefgspaced_out + zspaced_outl/zn;
    abcdefgperished = abcdefgperished + zperishedl/zn;
    abcdefgtargets = abcdefgtargets + ztargetsl/zn;
end
zwait_time = [7 7 7];

%abcdefgh Price war on yogurt (ie lower markup)
zmarkup = [.4 .1 .3];
abcdefghprofit = [0 0 0];
abcdefghlost_cust = [0 0 0];
abcdefghspaced_out = [0 0 0];
abcdefghperished = [0 0 0];
abcdefghtargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishable(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    abcdefghprofit = abcdefghprofit + zprofitl/zn;
    abcdefghlost_cust = abcdefghlost_cust + zlost_custl/zn;
    abcdefghspaced_out = abcdefghspaced_out + zspaced_outl/zn;
    abcdefghperished = abcdefghperished + zperishedl/zn;
    abcdefghtargets = abcdefghtargets + ztargetsl/zn;
end
zmarkup = [.4 .3 .3];

%i Non-fifo goods with short shelf lives
zlifespan = [1 2 3];
iprofit = [0 0 0];
ilost_cust = [0 0 0];
ispaced_out = [0 0 0];
iperished = [0 0 0];
itargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishablenonfifo(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    iprofit = iprofit + zprofitl/zn;
    ilost_cust = ilost_cust + zlost_custl/zn;
    ispaced_out = ispaced_out + zspaced_outl/zn;
    iperished = iperished + zperishedl/zn;
    itargets = itargets + ztargetsl/zn;
end
zlifespan = [7 14 21];

%j Price war on eggs and limited storage space
zmarkup = [.4 .3 .1];
zstorage_space = 9;
jprofit = [0 0 0];
jlost_cust = [0 0 0];
jspaced_out = [0 0 0];
jperished = [0 0 0];
jtargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishable(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    jprofit = jprofit + zprofitl/zn;
    jlost_cust = jlost_cust + zlost_custl/zn;
    jspaced_out = jspaced_out + zspaced_outl/zn;
    jperished = jperished + zperishedl/zn;
    jtargets = jtargets + ztargetsl/zn;
end
zstorage_space = -1;
zmarkup = [.4 .3 .3];

% Short shelf life and shipping available the next day
zlifespan = [1 2 3];
zwait_time = [1 1 1];
kprofit = [0 0 0];
klost_cust = [0 0 0];
kspaced_out = [0 0 0];
kperished = [0 0 0];
ktargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishable(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    kprofit = kprofit + zprofitl/zn;
    klost_cust = klost_cust + zlost_custl/zn;
    kspaced_out = kspaced_out + zspaced_outl/zn;
    kperished = kperished + zperishedl/zn;
    ktargets = ktargets + ztargetsl/zn;
end
zwait_time = [7 7 7];
zlifespan = [7 14 21];

% m Next day shipping and short shelf life and non-fifo
zlifespan = [1 2 3];
zwait_time = [1 1 1];
mkprofit = [0 0 0];
mklost_cust = [0 0 0];
mkspaced_out = [0 0 0];
mkperished = [0 0 0];
mktargets = [0 0 0];
for zi=1:zn
    disp(zi);
    [zprofitl, zlost_custl, zspaced_outl, zperishedl, ztargetsl] = perishablenonfifo(zdemand, zstorage_space, zwait_time, zlifespan, zmarkup, zsell);
    mkprofit = mkprofit + zprofitl/zn;
    mklost_cust = mklost_cust + zlost_custl/zn;
    mkspaced_out = mkspaced_out + zspaced_outl/zn;
    mkperished = mkperished + zperishedl/zn;
    mktargets = mktargets + ztargetsl/zn;
end
zwait_time = [7 7 7];
zlifespan = [7 14 21];