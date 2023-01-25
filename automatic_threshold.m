function T = automatic_threshold(gm)
    [m,n] = size(gm);
    buffer = 4;
    gm = rescale(gm, 0, 255);
    padGM = padarray(gm, [buffer/2 buffer/2], "symmetric");

    for ci=1:m
    T(ci) = var(padGM(ci:buffer+ci, ci:buffer+ci), 0, "all");
    end
end