clear;
max_fea = 300;
clus_iter = 50;
param_arr = [0.001, 0.01, 0.1, 1, 10, 100, 1000];
idx = 0;
param_struct = struct('alg', {}, 'param', {}, 'fea', {}, 'time', {});
idx = idx+1;
param_struct(idx).alg = 'LS';
param_struct(idx).param = 0;
param_struct(idx).fea = zeros(size(param_struct(idx).param, 1), max_fea);
param_struct(idx).time = zeros(size(param_struct(idx).param, 1), 1);

idx = idx+1;
param_struct(idx).alg = 'MAX_VAR';
param_struct(idx).param = 0;
param_struct(idx).fea = zeros(size(param_struct(idx).param, 1), max_fea);
param_struct(idx).time = zeros(size(param_struct(idx).param, 1), 1);


idx = idx+1;
param_struct(idx).alg = 'EGCFS';
param_struct(idx).param = [0.001, 0.1];
param_struct(idx).fea = zeros(size(param_struct(idx).param, 1), max_fea);
param_struct(idx).time = zeros(size(param_struct(idx).param, 1), 1);


idx = idx+1;
param_struct(idx).alg = 'U2FS';
param_struct(idx).param = 0;
param_struct(idx).fea = zeros(size(param_struct(idx).param, 1), max_fea);
param_struct(idx).time = zeros(size(param_struct(idx).param, 1), 1);

idx = idx+1;
param_struct(idx).alg = 'VCSDFS';
param_struct(idx).param = 100;
param_struct(idx).fea = zeros(size(param_struct(idx).param, 1), max_fea);
param_struct(idx).time = zeros(size(param_struct(idx).param, 1), 1);

idx = idx+1;
param_struct(idx).alg = 'FMIUFS';
param_struct(idx).param = 0.1;
param_struct(idx).fea = zeros(size(param_struct(idx).param, 1), max_fea);
param_struct(idx).time = zeros(size(param_struct(idx).param, 1), 1);

idx = idx+1;
param_struct(idx).alg = 'PROPQNY';
param_struct(idx).param = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8]';
param_struct(idx).fea = zeros(size(param_struct(idx).param, 1), max_fea);
param_struct(idx).time = zeros(size(param_struct(idx).param, 1), 2);


save('exp_setting.mat', 'param_struct');
save('exp_setting.mat', 'max_fea', '-append');
save('exp_setting.mat', 'clus_iter', '-append');
