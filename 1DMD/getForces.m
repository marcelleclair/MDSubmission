function F_total = getForces(p, x0)
% Return a vector of forces acting on each particle in the structure p
% Inputs:
%   p - Structure of all particles
%   x0 - minimum energy distance between particles
% Outputs:
%   F - Vector of forces acting on each particel in p

k = 15;
d = diff(p.x);

F = @(d) (k .* (d - x0).^2) .* sign(d - x0);

Fx = F(d);
F_total = [Fx 0] - [0 Fx];

end