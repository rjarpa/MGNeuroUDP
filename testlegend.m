% create some arbitrary data
% the data will be scales of sine, cosine, and tangent curves
t = (0:.1:2*pi)';
x = sin(t);
sc = linspace(.8,1.2,10);   % scaling matrix
x1 = repmat(x,1,10);
x1 = x1.*repmat(sc,length(t),1);
x = cos(t);
x2 = repmat(x,1,10);
x2 = x2.*repmat(sc,length(t),1);
x = tan(t);
x3 = repmat(x,1,10);
x3 = x3.*repmat(sc,length(t),1);
% plot the data
hf = figure;
hsin = plot(t,x1,'r');
hold on
hcos = plot(t,x2,'g');
htan = plot(t,x3,'b');
axis([0 2*pi -2 2])
% extract the handles that require legend entries
hleglines = [hsin(1) hcos(1) htan(1)];
% create the legend
hleg = legend(hleglines,'sine curves','cosine curves','tangent curves');