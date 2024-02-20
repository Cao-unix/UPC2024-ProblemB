% 定义常数和参数
g = 9.8;      % 重力加速度
m1 = 25;       % 物体1的质量
m2 = 40;       % 物体2的质量
m3 = 50;       % 物体3的质量
t0 = 0.0;     % 初始时间
tf = 800.0;    % 结束时间
dt = 0.0000015;    % 时间步长
N = 60;       %弹簧个数
k = 96000;    %每个弹簧的劲度系数
R = 5;        %蹦床面半径
% 初始化数组
t = t0:dt:tf;
n = length(t);
y1 = zeros(1, n);  % 物体1的位置
y2 = zeros(1, n);  % 物体2的位置
y3 = zeros(1, n);  % 物体3的位置
v1 = zeros(1, n);  % 物体1的速度
v2 = zeros(1, n);  % 物体2的速度
v3 = zeros(1, n);  % 物体3的速度

% 初始条件
y1(1) = 0.5;       % 物体1的初始位置
y2(1) = 0.8;      % 物体2的初始位置
y3(1) = 1.2;      % 物体2的初始位置
v1(1) = 0;       % 物体1的初始速度
v2(1) = 0;       % 物体2的初始速度
v3(1) = 0;       % 物体2的初始速度

% 数值求解
for i = 1:n-1
    % 物体2接触弹簧，物体1自由落体
    if y1(i) >= y2(i)&&y3(i) >= y2(i)&&y2(i) <= 0
        F2 = -N*k*(sqrt(R*R+y2(i)*y2(i))-R)*y2(i)/sqrt(R*R+y2(i)*y2(i));    % 弹簧力  
        a2 = (F2  - m2 * g) / m2;       % 物体2的加速度
        a1 = -g;                      % 物体1的加速度
        a3 = -g;                      % 物体3的加速度
    % 物体2接触弹簧，物体1自由落体
    elseif y2(i) >= y1(i)&&y3(i) >= y1(i)&&y1(i) <= 0
        F1 = -N*k*(sqrt(R*R+y1(i)*y1(i))-R)*y1(i)/sqrt(R*R+y1(i)*y1(i));     % 弹簧力
        a2 = -g;                      % 物体1的加速度
        a1 = (F1 - m1 * g) / m1;       % 物体2的加速度
        a3 = -g;                           % 物体3的加速度
    elseif y2(i) >= y3(i)&&y1(i) >= y3(i)&&y3(i) <= 0
        F3 = -N*k*(sqrt(R*R+y3(i)*y3(i))-R)*y3(i)/sqrt(R*R+y3(i)*y3(i));    % 弹簧力
        a2 = -g;                      % 物体2的加速度
        a1 = -g;                      % 物体1的加速度
        a3 = (F3 - m3 * g) / m3;       % 物体3的加速度
    else
        a1=-g;  % 物体1的加速度
        a2=-g;  % 物体2的加速度
        a3=-g;  % 物体3的加速度
    end
    
    v1(i + 1) = v1(i) + a1 * dt;       % 更新物体1的速度
    v2(i + 1) = v2(i) + a2 * dt;       % 更新物体2的速度
    v3(i + 1) = v3(i) + a3 * dt;       % 更新物体3的速度
    y1(i + 1) = y1(i) + (v1(i + 1)+v1(i))/2 * dt; % 更新物体1的位置
    y2(i + 1) = y2(i) + (v2(i + 1)+v2(i))/2 * dt; % 更新物体2的位置
    y3(i + 1) = y3(i) + (v3(i + 1)+v3(i))/2 * dt; % 更新物体3的位置
end


% 绘制结果
figure;
plot(t, y1, 'b-', 'LineWidth', 1);
hold on;
plot(t, y2, 'r-', 'LineWidth', 1);
hold on;
plot(t, y3, 'g-', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Position (m)');
title('Objects on a Spring');
legend('Object 1', 'Object 2','Object 3');
grid on;