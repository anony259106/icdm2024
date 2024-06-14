function [idx, time] = ufs_alg(name, X, Y, max_fea, param)
if max_fea > size(X, 2)
    m = size(X, 2);
else
    m = max_fea;
end
if size(Y, 2) > 1
    c_num = 2;
else
    c_num = length(unique(Y));
end
switch name
    case 'LS'
        tic
        idx = UFS_LS(X, m);
        idx = idx';
        time = toc;
    case 'UDFS'
        tic
        idx = udfs(X, c_num, param(1, 1), param(1, 2));
        idx = idx(1, 1:m);
        time = toc;
    case 'NDFS'
        tic
        idx = NDFS(X, 100, param(1, 1), 1, param(1, 2));
        idx = idx(1, 1:m);
        time = toc;
    case 'MCFS'
        tic
        idx = MCFS_p(X, m);
        time = toc;
    case 'MAX_VAR'
        tic
        idx = maxvar(X);
        idx = idx(1:m, 1);
        idx = idx';
        time = toc;
    case 'CNAFS'
        tic
        [~, ~, idx, ~] = CNAFS(X', c_num, param(1, 1), param(1, 2), param(1, 3), param(1, 4));
        idx = idx(1:m, 1);
        idx = idx';
        time = toc;
    case 'DUFS'
        tic
        idx = dufs();
        idx = idx(1:m, 1);
        idx = idx';
        time = toc;
    case 'EGCFS'
        tic
        [~, idx, ~] = EGCFS_TNNLS(X', c_num, param(1, 1), param(1, 2), m);
        idx = idx(1:m, 1);
        idx = idx';
        time = toc;
    case 'RUFS'
        tic
        idx = RUFS(X, c_num, param(1, 1), param(1, 2));
        idx = idx(1:m, 1);
        idx = idx';
        time = toc;
    case 'SOCFS'
        tic
        idx = SOCFS(X, param(1, 1), param(1, 2));
        idx = idx(1, 1:m);
        time = toc;
    case 'U2FS'
        tic
        idx = u2fs(X, c_num, m, {});
        idx = idx';
        time = toc;
    case 'FMIUFS'
        tic
        idx = FMIUFS(X, param(1,1), m);
        time = toc;
    case 'FRUAR'
        tic
        idx = FRUAR(X, param(1,1), m);
        time = toc;
    case 'UAR_HKCMI'
        tic
        idx=uar_HKCMI(X,param(1, 1),param(1, 2));
        time = toc;
    case 'IUFS'
        tic
        idx = iufs(X, m);
        idx = idx';
        time = toc;
    case 'VCSDFS'
        tic
        idx = vcsdfs(X, param(1, 1), m, 100);
        idx = idx(1:m, 1);
        idx = idx';
        time = toc;
    case 'PROP'
        tic
        idx = transpose(proposed(X, m));
        time = toc;
    case 'PROPQ'
        [idx, time] = proposed_quad(X, m);
        idx = idx';

    case 'PROP_REV'
        tic
        idx = transpose(proposed_reverse(X, m));
        time = toc;
    case 'RANK'
        idx = rankufs(X, c_num, param(1, 1), param(1, 2), param(1, 3));
        idx = idx(1:m, 1);
        idx = idx';
    case 'PROPQNY'
        [idx, time] = proposed_quad_ny(X, m, param(1, 1));
        idx = idx';
end
end

