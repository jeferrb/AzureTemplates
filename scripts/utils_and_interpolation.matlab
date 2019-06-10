
% Generic interpolation algorithm from toy2dac original marmousi
lenx=141
leny=681
increasing=0.1
files = {"rho","qp","vp_Marmousi_exact","vp_Marmousi_init"}
for file=files
	f = fopen(file{1}); # _exact, qp e rho
	v = fread(f,[lenx,leny],"float");
	x = linspace(0,(leny-1)*(25/1000),leny);
	z = linspace(0,(lenx-1)*(25/1000),lenx);
	xx =linspace(0,(leny-1)*(25/1000),(leny-1)*increasing+1);
	zz = linspace(0,(lenx-1)*(25/1000),(lenx-1)*increasing+1);
	vi = interp2(x',z,v,xx',zz,'spline'); #interpolando
	vi(vi<1500.) = 1500;
	% imagesc(vi) #visualizar
	outfile=strjoin({file{1},num2str((lenx-1)*increasing+1),num2str((leny-1)*increasing+1)}, '_')
	outfile=strjoin({outfile, 'bin'}, '.')
	f = fopen(outfile, 'wb');
	fwrite(f,vi, "float")
	fclose(f);
endfor




% Extra (visualization, smooth, ...)
f = fopen("vp_Marmousi_exact");
f = fopen("param_vp_final");
v = fread(f,[140+1,inf],"float");
size(f)
imagesc(v);
v(v<1500.) = 1500;
f = fopen("marmousi_init_751_2301.bin"); # _exact, qp e rho
v = fread(f,[751,2301],"float");
x = linspace(0,9.2,2301);
z = linspace(0,3,751);
xx =linspace(0,9.2,2300*2+1);
zz = linspace(0,3,750*2+1);
vi = interp2(x',z,v,xx',zz,'spline'); #interpolando
imagesc(vi) #visualizar
f = fopen("marmousi_init_4600_1500.bin", 'wb');
fwrite(f,vi, "float")
fclose(f);