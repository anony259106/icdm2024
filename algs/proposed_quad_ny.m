function [res, time] = proposed_quad_ny(X, max_feat, k_per)
time = zeros(1, 2);
tic
fcol = size(X,2);

k = round(fcol * k_per);

A = zeros(k, k);
B = zeros(k, fcol-k);

for i = 1:k
    for j = i:k
        A(i,j) = p_entropy([X(:,i), X(:,j)]);
        if i == j
            A(i,j) = A(i, j) / 2;
        end
    end
end
A = A + A';

for i = 1:k
    for j = k+1:fcol
        B(i,j-k) = p_entropy([X(:,i), X(:,j)]);
    end
end

E = B' / A * B;
ff_ent = [A, B; B', E];
time(1, 1) = toc;
tic
% eigenvector of ff_ent
[V,D] = eig(ff_ent);
eigenvalues = diag(D);
[~, idx] = max(eigenvalues);

% 최대 고유값에 해당하는 고유벡터
max_v = V(:, idx);
max_v = abs(max_v);
[~, idx] = sort(max_v, 'descend');
res = idx(1:max_feat);
res = res';
time(1, 2) = toc;
end

function [res] = p_entropy( vector )

[uidx,~,single] = unique( vector, 'rows' );
count = zeros(size(uidx,1),1);
for k=1:size(vector,1)
    count( single(k), 1 ) = count( single(k), 1 ) + 1;
end
res = -( (count/size(vector,1))'*log2( (count/size(vector,1)) ) );
end
