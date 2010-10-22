% Do the example in fig 23.4 p479 of Cormen, Leiserson and Rivest (1994)

% This file is from matlabtools.googlecode.com


u = 1; v = 2; w = 3; x = 4; y = 5; z = 6;
n = 6;
dag=zeros(n,n);
dag(u,[v x])=1;
dag(v,y)=1;
dag(w,[y z])=1;
dag(x,v)=1;
dag(y,x)=1;
dag(z,z)=1;

directed = 1;
root = 1;
[d, pre, post, cycle, f, pred] = dfsPMTK(dag, [], directed);
[d2 dt ft pred2] = dfs(dag, root, 1)
d3 = dt+1; d3(root)=1;
% we can extract pre-order by sorting nodes based on discovery time
[junk pre1] = sort(d3)
[junk pre2] = sort(d)

assert(isequal(d, [1 2 9 4 3 10]))
assert(isequal(f, [8 7 12 5 6 11]))
assert(cycle==1)

% Now give it an undirected cyclic graph
%G = mk_2D_lattice(2,2,0);
G = mkGrid(2,2,0);
% 1 - 3
% |   |
% 2 - 4
[d, pre, post, cycle, f, pred] = dfsPMTK(G, [], 0);
% d = [1 2 4 3]
fprintf('cycle found (should be true)? %d\n', cycle)

% Now break the cycle
G(1,2)=0; G(2,1)=0;
[d, pre, post, cycle, f, pred] = dfsPMTK(G, [], 0);
assert(~cycle)
