function [K, K2comp] = complexkernel(XM, XN, theta, c)
    %% informative features
    XMc = XM(:, 2:end);
    XNc = XN(:, 2:end);
    K2 = theta(1)*exp(-theta(2)*pdist2(XMc, XNc).^2);
    %% ID feature
    IDM = XM(:, 1);
    IDN = XN(:, 1);
    K1 = repmat(IDM, 1, length(IDN)) == repmat(IDN', length(IDM), 1);
    K1(K1 ~= 1) = c;
    %% final result
    K = K1.*K2;
end