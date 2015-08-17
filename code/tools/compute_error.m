function e = compute_error(A, B)
% COMPUTE_ERROR Compute relative error between two arrays

    e = norm(A(:)-B(:)) / norm(A(:));
end