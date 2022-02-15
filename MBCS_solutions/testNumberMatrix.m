
function testNumberMatrix(nRows, nCols)
%testNumberMatrix    Summary of this function goes here
%   Detailed explanation goes here

nRows = 4
nCols = 8
numbermat = rand(nRows,nCols);

for rowi=1:nRows
    for coli=1:nCols

        if numbermat(rowi,coli) > .5
            testResult = 'bigger than';
        else testResult = 'not bigger than';
        end

        if rowi==1
            numberr='st';
        elseif rowi==2
            numberr='nd';
        else numberr='th';
        end

        if coli==1
            numberc='st';
        elseif coli==2
            numberc='nd';
        else numberc='th';
        end

        disp([ 'The ' num2str(rowi) numberr ' row and ' num2str(coli) numberc ' column (' num2str(numbermat(rowi,coli)) ') is ' testResult ' 0.5.' ]);
        %i made a new variable numberr and numberc to fill in the st/nd/th
        %per loop
    end % end column-loop
end % end row-loop
end
