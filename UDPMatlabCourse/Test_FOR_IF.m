ED = [30 33 25 0 42 20 19 82 38 26]';

for jj = 1:1:10
    if (ED(jj)<10) || (ED(jj)>50)
        ED(jj)=nan;
    end
end

ED = [30 33 25 0 42 20 19 82 38 26]';
%% CREATE SECTION DOUBLE PERCENTAE
jj = 1;
while jj <= 10
    if (ED(jj)<10) || (ED(jj)>50)
        ED(jj)=nan;
    end
    jj = jj + 1;
end