% 定义常数和参数
g = 9.8;      % 重力加速度
k = 96000;     % 弹簧劲度系数
m1 = 25;       % 物体1的质量
m2 = 40;       % 物体2的质量
t0 = 0.0;     % 初始时间
tf = 100.0;    % 结束时间
dt = 0.0002;    % 时间步长
R = 5;
N = 60;
Sh = 0.08;
Ca = 2.3;
Cd = 16;
Fc = 2.5;
Pi = 3.14;
E1 =180;
E2 =328;
E3 =538;
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
y1(1) = 0;       % 物体1的初始位置
y2(1) = 0;      % 物体2的初始位置
v1(1) = 0;       % 物体1的初始速度
v2(1) = 0;       % 物体2的初始速度

% 数值求解
for i = 1:n-1
    % 物体1接触弹簧，物体2自由落体
    if y1(i) >= y2(i)&&y2(i) <= 0
        Ft = -N*k*(sqrt(R*R+y2(i)*y2(i))-R)*y2(i)/sqrt(R*R+y2(i)*y2(i));     % 弹簧力
        Fa = Pi*Ca*R*R*R*v2(i)*v2(i)*sign(v2(i))/(sqrt(R*R+y2(i)*y2(i))*6);
        Fd = -Cd*v2(i)*sign(v2(i));
        Fc = 2.5*sign(v2(i));
        Fm1 = - Ca*Sh*(v1(i)*v1(i))*sign(v1(i));
        a2 = (Ft-Fa-Fd-Fc - m2 * g) / m2;       % 物体1的加速度
        a1 = -g+Fm1/m1;                      % 物体2的加速度
    % 物体2接触弹簧，物体1自由落体
    elseif y2(i) >= y1(i)&&y1(i) <= 0
        Ft = -N*k*(sqrt(R*R+y1(i)*y1(i))-R)*y1(i)/sqrt(R*R+y1(i)*y1(i));     % 弹簧力
        Fa = Pi*Ca*R*R*R*v1(i)*v1(i)*sign(v1(i))/(sqrt(R*R+y1(i)*y1(i))*6);
        Fd = -Cd*v1(i)*sign(v1(i));
        Fc = 2.5*sign(v1(i));
        Fm2 = - Ca*Sh*(v2(i)*v2(i))*sign(v2(i));
        a1 = (Ft-Fa-Fd-Fc - m1 * g) / m1;       % 物体2的加速度
        a2 = -g+ Fm2/m2;
    else
        a1 = -g+Fm1/m1; 
        a2 = -g+ Fm2/m2;
    end
    v1(i + 1) = v1(i) + a1 * dt; 
    if v1(i)<=0&&v1(i+1)>=0&&y2(i) >= y1(i)&&y3(i) >= y1(i)
    y1(i + 1) = y1(i) + (v1(i)+v1(i+1))/2 * dt-y1(i)-((E1+28800*y1(i)^4)^0.25)/(2*sqrt(2*sqrt(2))*sqrt(15)); % 更新物体1的位置
    else
    y1(i + 1) = y1(i) + (v1(i)+v1(i+1))/2 * dt; % 更新物体1的位置
    end
    v2(i + 1) = v2(i) + a2 * dt;       % 更新物体2的速度
    if v2(i)<=0&&v2(i+1)>=0&&y1(i) >= y2(i)&&y3(i) >= y2(i)
    y2(i + 1) = y2(i) + (v2(i)+v2(i+1))/2* dt-y2(i)-((E2+28800*y2(i)^4)^0.25)/(2*sqrt(2*sqrt(2))*sqrt(15)); % 更新物体1的位置
    else
    y2(i + 1) = y2(i) + (v2(i)+v2(i+1))/2 * dt; % 更新物体1的位置
    end
    
end
% 绘制结果
figure;
plot(t, y1, 'b-', 'LineWidth', 1);
hold on;
plot(t, y2, 'r-', 'LineWidth', 1);
hold on;
xlabel('Time (s)');
ylabel('Position (m)');
title('Two kids on the trampoline');
legend('Kid 1', 'Kid 2');
grid on;