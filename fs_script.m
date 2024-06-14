% get result of feature selction
clear;

data_dir = './data/';
% list of data which name has '.mat'
data_list = dir([data_dir, '*.mat']);
data_list = {data_list.name};

fs_dir = './result/';
fs_list = dir([fs_dir, '*.mat']);
fs_list = {fs_list.name};

save_dir = './result_fs/';
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

max_fs_size = 300;
for k = 1:length(fs_list)

    load([data_dir data_list{k}]);
    data_name = data_list{k}(1:end-4);
    load([fs_dir strcat(data_name, '.mat')]);
    [~, col] = size(fea);
    max_col = min(max_fs_size, col);
    fs_size = 1:max_col;
    res = struct('alg', {}, 'pdp', {}, 'ent', {});
    for alg_idx = 1:length(param_struct)
        alg = param_struct(alg_idx).alg;
        res(alg_idx).alg = alg;
        if strcmp(alg, 'RAND')
            rand_size = size(param_struct(alg_idx).fea, 1);
            table_pdp = zeros(rand_size, length(fs_size));
            table_ent = zeros(rand_size, length(fs_size));
            fs_list = param_struct(alg_idx).fea;
            if cate_flag == 0
                fea = discretize_width(fea, 10);
            end
            for rand_idx = 1:rand_size
                for fs_idx = 1:length(fs_size)
                    fs = fs_size(fs_idx);
                    X_fs = fea(:, fs_list(rand_idx, 1:fs));
                    table_pdp(rand_idx, fs_idx) = uniqueness(X_fs);
                    table_ent(rand_idx, fs_idx) = ent_s(X_fs);
                end
            end
            table_pdp = mean(table_pdp, 1);
            table_ent = mean(table_ent, 1);
        else
            table_pdp = zeros(1, length(fs_size));
            table_ent = zeros(1, length(fs_size));
            fs_list = param_struct(alg_idx).fea;
            if cate_flag == 0
                fea = discretize_width(fea, 10);
            end
            for fs_idx = 1:length(fs_size)
                fs = fs_size(fs_idx);
                X_fs = fea(:, fs_list(1:fs));
                table_pdp(1, fs_idx) = uniqueness(X_fs);
                table_ent(1, fs_idx) = ent_s(X_fs);
            end
        end
        res(alg_idx).pdp = table_pdp;
        res(alg_idx).ent = table_ent;
    end
    save_name = strcat(save_dir, data_name, '_fs.mat');
    save_file(save_name, res);
end

function save_file(save_dir, res)
    save(save_dir, 'res');
end
