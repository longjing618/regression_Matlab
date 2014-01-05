%Validation data set
Y = data(ceil(numberofdata*0.4):ceil(numberofdata*0.5),2:end);
TY = data(ceil(numberofdata*0.4):ceil(numberofdata*0.5),1);
numberofvalidatedata = numel(Y(:,1));

%Test data set
test = data(ceil(numberofdata*0.5):end,2:end);
testY = data(ceil(numberofdata*0.5):end,1);
numberoftestdata = numel(test(:,1));

%Calculate ERMS for validation data set
%for M = 2:50
for l = 1:numel(lamda)
%for M = 10:5:50 %compare lamda with different M
%M = 25;
validatematrix = ones(numberofvalidatedata,1);
for i = 1:M-1
    tmp = Y;
    for m = 1:numberoffeatures      
        tmp(:,m) = -(tmp(:,m)-meanset((i-1)*46+m)).*(tmp(:,m)-meanset((i-1)*46+m));
        tmp(:,m) = exp(tmp(:,m)/(2*varset(m)));
    end
    validatematrix = cat(2,validatematrix,tmp);
end
EDWV = 0;

for i = 1:numberofvalidatedata
    EDWV = EDWV + (TY(i) - WmlR{M}'*validatematrix(i,:)')^2; 
    %EDWV = EDWV + (TY(i) - lam{l}{M}'*validatematrix(i,:)')^2; 
    predic(i) = WmlR{M}'*validatematrix(i,:)';
end
EDWV = EDWV/2;
EDWVS(M-1) = sqrt(2*EDWV/numberofvalidatedata);
end


%Calculate ERMS for test data set
for l = 1:numel(lamda)
%for M = 10:5:50 %compare lamda with different M
%M = 35;
testmatrix = ones(numberoftestdata,1);
for i = 1:M-1
    tmp = test;
    for m = 1:numberoffeatures      
        tmp(:,m) = -(tmp(:,m)-meanset((i-1)*46+m)).*(tmp(:,m)-meanset((i-1)*46+m));
        tmp(:,m) = exp(tmp(:,m)/(2*varset(m)));
    end
    testmatrix = cat(2,testmatrix,tmp);
end
EDWV = 0;

for i = 1:numberoftestdata
    EDWV = EDWV + (testY(i) - WmlR{M}'*testmatrix(i,:)')^2; 
    %EDWV = EDWV + (testY(i) - lam{l}{M}'*testmatrix(i,:)')^2; 
    predic(i) = WmlR{M}'*testmatrix(i,:)';
end
EDWV = EDWV/2;
EDWTS(M-1) = sqrt(2*EDWV/numberoftestdata);
end

%EDWVS(M-1);

%xM = [5,10,15,20,25,30,35,40,45];
%ylambda = [0.1,0.5,0.9,1.5,2.2,2.5,3,3.5,4,4.5,5,5.5,6,7,8,9];
%zERMS = [0.4998409,0.5006931,0.5012554,0.5017442,0.5020742,0.5023256,0.5025137,0.5026944,0.5028378;0.4990035,0.4991592,0.4995987,0.5001788,0.5006531,0.5010373,0.5013296,0.5016159,0.5018527;0.4993451,0.4989923,0.4991588,0.4995861,0.500028,0.5004303,0.5007575,0.5010905,0.5013713;0.4999166,0.4991628,0.4990213,0.4992101,0.4995418,0.4999028,0.5002275,0.5005804,0.500893;0.5003067,0.499394,0.4990746,0.499096,0.4993313,0.49964,0.4999422,0.5002888,0.5006087;0.5006228,0.4996337,0.4991872,0.4990695,0.4992154,0.4994688,0.4997418,0.5000719,0.5003892;0.5008817,0.499863,0.4993256,0.499093,0.4991582,0.4993577,0.4995988,0.4999075,0.5002161;0.5010975,0.5000762,0.4994743,0.4991468,0.4991397,0.4992881,0.499497,0.4997816,0.500078;0.5012804,0.5002724,0.4996254,0.4992195,0.499148,0.4992484,0.4994258,0.4996853,0.4999671;0.5014382,0.5004525,0.4997747,0.4993041,0.4991752,0.499231,0.4993779,0.4996118,0.499878;0.5015763,0.5006182,0.4999202,0.4993961,0.4992161,0.4992305,0.4993482,0.4995569,0.4998066;0.5016989,0.5007709,0.5000608,0.4994926,0.4992671,0.4992432,0.499333,0.499517,0.4997498;0.5018089,0.5009122,0.500196,0.4995915,0.4993256,0.4992662,0.4993295,0.4994894,0.4997053;0.5020004,0.5011661,0.5004503,0.4997919,0.4994578,0.4993351,0.4993496,0.4994535,0.499646;0.5021639,0.5013889,0.5006842,0.4999906,0.4996023,0.4994355,0.4993961,0.4994674,0.4996175;0.5023077,0.5015875,0.5008999,0.5001845,0.4997533,0.4995301,0.4994614,0.4994931,0.4996122;];
%mesh(xM,ylambda,zERMS,'EdgeColor','blue');
%surf(xM,ylambda,zERMS);
%xlabel('M');
%ylabel('lambda');
%zlabel('\itE_{RMS}');
%title('\itE_{RMS} under different M and lambda');
%colormap hsv;
%colorbar;
%alpha(.4);

 
%plot(testY,'b');
%hold on;
%plot(predic,'g');
%description = legend('true values','predicted values');
%xlabel('X','FontWeight','bold');
%ylabel('Y');
%title('\itpredicted value for test data set');
%title('\ittrue value and predicted value for test data set');

%result{l} = EDWVS;
%figure(1);
%plot(ERMSR);
%xlabel('\itM');
%ylabel('\itE_{RMS}');
%title('\itroot-mean-square error for different M with training data');
%figure(2);
%plot(EDWVS);
%xlabel('\itM');
%ylabel('\itE_{RMS}');
%title('\itroot-mean-square error for different M with validation data');
%end

%for m = 1:numel(lam)
%    for n = 10:5:50
%        fprintf('%i ',result{m}(n-1));
%    end
%    fprintf('\n');
%end


lambda = lamda(1);
mu = meanset;
s = varset;
rms_lr = EDWTS(M-1);
fprintf('the model complexity M for the linear regression model is %d', M);
fprintf('\n');
fprintf('the regularization parameters lambda for the linear regression model is %f', lambda)
fprintf('\n');
%fprintf('the hyperparameter mu for the linear regression model is %f', mu)
%fprintf('the hyperparameter s for the linear regression model is %f', s)
fprintf('the root mean square error for the linear regression model is %f', rms_lr)
fprintf('\n');
%fprintf('the root mean square error for the neural network model is %f', rms_nn);