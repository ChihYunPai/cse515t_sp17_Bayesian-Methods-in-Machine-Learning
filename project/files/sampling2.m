[train,idx_train]=datasample(train_sort,3500,1,'Replace',false);
yTr=train(:,end);
xTr=train(:,1:end-1);
