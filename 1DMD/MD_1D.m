% initialize
p.x = linspace(-2,2,5);
p.y = zeros(1,5);
p.m = ones(1,5);
p.v = zeros(1,5);

ScaleF = 0.5;
atomSpacing = 1;
% perturb the atom positions
p.x = p.x + 0.5.*(rand(1,5) - 0.5);
%p.x = p.x .* atomSpacing .* 0.5 .* cos(p.x);
t = 0;
dt = 1e-3;
t_max = 10;

while t < t_max
    F = getForces(p,atomSpacing);
    % plot particles with forces
    plot(p.x, 0, 'bo');
    hold on
    quiver(p.x, p.y, F .* ScaleF, p.y, 0, 'm', 'linewidth', 2);
    xlim([-5 5]);
    ylim([-1 1]);
    hold off
    fprintf("Time = %3.3f s\n", t);
    % compute new positions and velocities
    x = p.x + p.v.*dt + 0.5.*F.*(dt^2)./p.m;
    v = (x - p.x) ./ dt;
    % update particle struct
    p.x = x;
    p.v = v;
    t = t + dt;
    pause(0.016)
end