function AddSierpinskiAtomic(order, X0, Y0, VX0, VY0, InitDist, Temp, Type)
global C
global x y AtomSpacing
global nAtoms
global AtomType Vx Vy Mass0 Mass1

if Type == 0
    Mass = Mass0;
else
    Mass = Mass1;
end

% unit vectors to transform square matrix to equilateral triangle lattice
% ri for rows, rj for columns
ri = AtomSpacing .* [0.5 -sqrt(3)/2];
rj = AtomSpacing .* [0.5 sqrt(3)/2];

function S = Sierpinski(n)
    if n > 0
        S = Sierpinski(n-1);
        S = [S S; 0.*S S];
    else
        S = 1;
    end
end

S = Sierpinski(order);
[row,col] = find(S);
p = transpose(row*ri + col*rj);

xp = X0 + p(1,:);
yp = Y0 + p(2,:);

numAtoms = length(xp);
x = [x xp];
y = [y yp];

AtomType(nAtoms + 1:nAtoms + numAtoms) = Type;

if Temp == 0
    Vx(nAtoms + 1:nAtoms + numAtoms) = 0;
    Vy(nAtoms + 1:nAtoms + numAtoms) = 0;
else
    std0 = sqrt(C.kb*Temp/Mass);
    Vx(nAtoms + 1:nAtoms + numAtoms) = std0*randn(1, numAtoms);
    Vy(nAtoms + 1:nAtoms + numAtoms) = std0*randn(1, numAtoms);
end

Vx(nAtoms + 1:nAtoms + numAtoms) = Vx(nAtoms + 1:nAtoms + numAtoms) - ...
    mean(Vx(nAtoms + 1:nAtoms + numAtoms)) + VX0;
Vy(nAtoms + 1:nAtoms + numAtoms) = Vy(nAtoms + 1:nAtoms + numAtoms) - ...
    mean(Vy(nAtoms + 1:nAtoms + numAtoms)) + VY0;

nAtoms = nAtoms + numAtoms;

end
