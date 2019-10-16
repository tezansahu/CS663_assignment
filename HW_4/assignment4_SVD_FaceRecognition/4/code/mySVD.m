function [U, S, V] = mySVD(A)
  [m,n] = size(A);
  Q = A * A';
  [U, S_2] = eigs(Q); % Left singular vectors are eigenvectors of AA^T; Size of U = m * m
  S = sqrt(S_2); % Singular values are square roots of eigenvalues of AA^T; Size of S = m*m instead of m*n
  V = A' * U;  % Right singular values are calculated using approach provided in Q6
  for i = 1:size(V, 2)
    V(:, i) = V(:, i)/sqrt(sum(V(:, i).^2));
  end
  % In this approach, size of V = n*m instead of n*n
  recalc_A = U*S*V';
  sqr_err = sum(sum((A-recalc_A).*2));
  printf("Error: %f\n", sqr_err);
end
