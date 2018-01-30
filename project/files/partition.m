function [ID,xTr,yTr,xTe,yTe]=partition(data,train_num,test_num,val_num,opt1,value1);
% partition.m: paritioning data set into [train_set,test_set] or [train_set,val_set,test_set] by porportion to the number of (train_num,test_num,val_num)
% inputs:
%			data: orginal dataset [ID:nx1, X:nxd, reference:nx1]
%			train_num: porportion of training set 0~1.0
%			test_num: porpotion of test set 0~1.0
%			val_num: porportion of validation set 0~1.0
%			opt: options
%			value: value of opionts
% 
% if nargin < 1
% 	error('must have input dataset');
% end
% if nargin < 2
% 	train_num = .8;
% end
% if nargin < 3
% 	test_num=1-train_num;
% end
% if nargin < 4
% 	val_num = 0;
% end
% assert((train_num+test_num+val_num-1)<10e-4);
% % instances contain number of CTs for each ID
% reference = data(:,end);
% [n,d]=size(data);
% ID    = unique(data(:,1));
% instances = histc(data(:,1),ID);
% 
% if((train_num+test_num)==1)	
% 	train_num=round(train_num*length(ID));
% 	test_num=length(ID)-train_num;
% else % having vlidation set
% 	train_num=round(train_num*length(ID));
% 	test_num=round(test_num*length(ID));
% 	val_num=length(ID)-train_num-test_num;
% end
% % test for the numbers
% train_num
% test_num
% val_num
% total=train_num+test_num+val_num
% if(opt1)
% 	switch value1
% 	case {'ID','Id','id'}
% 		
% 	case {'no id','no ID','no Id','noID','noId'}
% 	otherwise % dedault no ID
% 
% 	end
% end
ID=data(:,1);

xTr=data(find(data(:,1)==[0:(train_num-1)]),2:end-1);
yTr=data(find(data(:,1)==[0:train_num-1]),end);
xTe=data(find(data(:,1)==[train_num:length(ID)-1]),2:end-1);
yTe=data(find(data(:,1)==[train_num:length(ID)-1]),end);


end