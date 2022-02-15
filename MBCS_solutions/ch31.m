%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 2

load ../ch31/kmeans_data

res = zeros(7,100);

for k=2:8

    for triali=1:100
        [groupidx,cents,sumdist,distances] = kmeans(d,k);

        dst = zeros(length(d),2);
        for i=1:length(d)
            whichgroup = false(k,1);
            whichgroup(groupidx(i)) = true;
            dst(i,1) = distances(i,whichgroup);
            dst(i,2) = mean( distances(i,~whichgroup') );
        end

        res(k-1,triali) = mean(dst(:,2)) - mean(dst(:,1));

    end % end trial
end % end k

plot(2:8,mean(res,2),'d-','linew',3,'markersize',15,'markerface','r')
xlabel('K extracted'), ylabel('own-other centroid distances')
set(gca,'xlim',[1.5 8.5])

%% 3

load ../ch31/EEG_LR

% initialize
accu = zeros(size(timevec));
trueLabels = [ones(size(l_eeg,3),1); 2*ones(size(r_eeg,3),1)];


% organize the data for this time point
tidx = dsearchn(timevec',[400 550]');
data = squeeze( cat(3, mean(l_eeg(:,tidx(1):tidx(2),:),2), mean(r_eeg(:,tidx(1):tidx(2),:),2) ))';

% fit the model
svmModel = fitcsvm(data,trueLabels);



% loop over time (skip some points for speed)
for ti=1:size(l_eeg,2)
    data = squeeze( cat(3, l_eeg(:,ti,:), r_eeg(:,ti,:) ))';
    catLabel = predict(svmModel,data);
    accu(ti) = mean(catLabel==trueLabels);
end

% show a time course of the average accuracy results
clf
plot(timevec,accu,'k','linew',2)
hold on
plot(get(gca,'xlim'),[.5 .5],'k--')
xlabel('Time (ms)'), ylabel('Accuracy')

%% 7

inputs = [ 1 0; 0 1; 1 1; 0 0 ];
output = [   0;   0;   1;   1 ];

inputs(:,1)==inputs(:,2)

%% 8

x = -3:.1:3;
af = tanh(x);

v = 2;
s = 2;
m = 0;

predY = v./(1 + exp( -s.*(x-m) ) ) - 1;
clf,plot(x,af,'linew',3)
hold on, plot(x,predY,'o','markersize',10,'markerface','r')

legend({'Sigmoid';'atanh'})

mean(abs(predY-af))

%% 9

% XOR patterns (first two numbers; the third number is for the bias term)
inputs = [ 1 0 1; 0 1 1; 1 1 1; 0 0 1 ];
output = [     0;     0;     1;     1 ];

% initialization
[outputs,predError] = deal( zeros(1,size(inputs,1)) );
totalError = nan(1,100);

% setup model
nInputsNodes = size(inputs,2);
nHiddenNodes = 3;
nOutputNodes = 1;

nIter = 50;
learned = zeros(30,nIter);
lrates = linspace(0,1,30);

for learni=1:length(lrates)
    l_rate = lrates(learni);

    for iteri=1:nIter
        % random initial weights
        weights_i2h = randn(nInputsNodes,nHiddenNodes);
        weights_h2o = randn(nHiddenNodes,nOutputNodes);


        toggle = true;
        iteration = 0;
        max_iterations = 300;

        while toggle

            % loop through inputs
            for ini=1:size(inputs,1)
                % input-layer to hidden-layer: raw input -> weights -> sigmoid
                hdLayerResp = inputs(ini,:) * weights_i2h;
                hdLayerResp = 2./(1+exp(-hdLayerResp'*2))-1;

                % input-layer to output-layer: input -> weights -> sigmoid
                otLayerResp = hdLayerResp' * weights_h2o;
                otLayerResp = 2./(1+exp(-otLayerResp'*2))-1;
                % prediction error
                predError(ini) = otLayerResp - output(ini);

                % collect output-layer responses for plotting
                outputs(ini) = otLayerResp;
                % adjust hidden -> output weights
                delta = l_rate * predError(ini) * hdLayerResp;
                weights_h2o = weights_h2o - delta;
                % adjust input -> hidden weights
                backprop = weights_h2o .* (1-hdLayerResp.^2) * inputs(ini,:);
                delta = l_rate * predError(ini) * backprop;
                weights_i2h = weights_i2h - delta';
            end

            iteration = iteration+1; % not auto-updated in a while loop!
            totalError(iteration) = sum(predError.^2);

            if totalError(iteration)<.01
                learned(learni,iteri)=1;
                toggle=false;
            end
            if iteration>max_iterations
                toggle=false;
            end

        end % end simulation while-loop

    end
end

plot(lrates,mean(learned,2),'ko-','linew',3,'markersize',15,'markerface','m')
xlabel('Learning rate'), ylabel('Proportion of successes')
set(gca,'ylim',[0 1])

%%
