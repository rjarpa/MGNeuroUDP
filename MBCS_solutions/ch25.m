%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

addpath('../ch25')

%% 2

strMRI = readnifti('MNI152_T1_1mm.nii');

for ori=1:3
    figure(ori), clf
    slices = round(linspace(1,size(strMRI,ori),12));
    for si=1:12
        subplot(3,4,si)

        switch ori
            case 1, imagesc(squeeze(strMRI(slices(si),:,:))');
            case 2, imagesc(squeeze(strMRI(:,slices(si),:))');
            case 3, imagesc(squeeze(strMRI(:,:,slices(si)))');
        end
        axis image, axis off, axis xy, colormap gray
    end
end

%% 4

clf
for i=1:6

    subplot(2,3,i)

    ds = strMRI(1:i:end,1:i:end,1:i:end);
    imagesc(squeeze(ds(:,:,round(.5*size(ds,3))))')
    axis image, axis off, axis xy, colormap gray
    p = numel(ds)*100/numel(strMRI);
    p = round(p*100)/100;
    title({ ['Downsample factor ' num2str(i)] , ['(' num2str(p) '% of original image)'] })
end

%% 5


filz = dir('../ch25/*img');
for imgi=1:length(filz)
    tempdat = readnifti(filz(imgi).name);
    if imgi==1, fmridat = zeros([ size(tempdat) length(filz) ]); end
    fmridat(:,:,:,imgi) = tempdat;
end

% and plot
clf
slices = round(linspace(10,50,4));
meanimg = squeeze(mean(fmridat,4));
stdimg  = squeeze(std(fmridat,[],4));
for si=1:4
    subplot(2,4,si)
    imagesc(squeeze(meanimg(:,:,slices(si)))');
    axis image, axis off, axis xy, colormap gray,
    set(gca,'clim',[3000 10000])
    title([ 'Mean image (slice ' num2str(slices(si)) ')' ])

    subplot(2,4,si+4)
    imagesc(squeeze(stdimg(:,:,slices(si)))');
    axis image, axis off, axis xy, colormap gray
    set(gca,'clim',[50 500])
    title([ 'Std. image (slice ' num2str(slices(si)) ')' ])
end

%%
