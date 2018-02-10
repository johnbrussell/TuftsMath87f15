avg = 0;
for i=1:3
tm = make_tm();
equitable_flex = .000001;
num_tests = 100000000;
dmc = cake_division(tm);
dml = loop_divide(tm, num_tests, equitable_flex);
dmlnl = ln_loop_divide(tm, num_tests, equitable_flex);
avg = (avg*(i-1) + (mean(mean(abs(dmc-dml)))))/i;
%disp(mean(mean(abs(dmc-dmlnl))));
end
disp(avg);