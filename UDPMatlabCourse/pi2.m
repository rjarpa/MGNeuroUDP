[row,col]=size(pi100000v2);
col=50;
varios=[];

for f=1:1:row
     C = regexp(pi100000v2(f),'[0-9]','match');

    for c=1:1:col
        bb=(C(c));
        varios(f,c)=uint8(str2num(bb));
       
        
    end
     f
end




