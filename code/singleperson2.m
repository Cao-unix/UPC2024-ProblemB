% 定义常数和参数
g = 9.8; % 重力加速度
Pi = 3.14;
k = 96000; % 弹簧劲度系数
R = 5;
N = 60;
Sh = 0.08;
Ca = 2.3;
Cd = 16;
Fc = 2.5;
E1 =180;
m1 = 40; % 物体的质量
t0 = 0.0; % 初始时间
tf = 20.0; % 结束时间
dt = 0.001; % 时间步长
% 初始化数组
t = t0:dt:tf;
n = length(t);
y1 = zeros(1, n); % 物体1的位置
v1 = zeros(1, n); % 物体1的速度
% 初始条件
y1(1) = 0; % 物体1的初始位置
v1(1) = 0; % 物体1的初始速度
% 数值求解
for i = 1:n-1
if y1(i) >=0 
% 物体1自由落体
Fm = Ca*Sh*(v1(i)*v1(i))*sign(v1(i));
a1 = -g-Fm/m1;
elseif y1(i) <= 0
% 物体1接触弹簧
 F = -N*k*(sqrt(R*R+y1(i)*y1(i))-R)*y1(i)/sqrt(R*R+y1(i)*y1(i)); % 弹簧力
Fa = Pi*Ca*R*R*R*v1(i)*v1(i)*sign(v1(i))/(6*sqrt(R*R+y1(i)*y1(i)));
Fd = -Cd*v1(i)*sign(v1(i));
Fc = 2.5*sign(v1(i));
a1 = -g+(F-Fa-Fd-Fc )/ m1; % 物体2、1的加速度
end
v1(i + 1) = v1(i) + a1 * dt; % 更新物体1的速度
if v1(i)<=0&&v1(i+1)>=0
y1(i + 1) = y1(i) + v1(i) * dt-y1(i)-((E1+28800*y1(i)^4)^0.25)/(2*sqrt(2*sqrt(2))*sqrt(15)); % 更新物体1的位置
else
y1(i + 1) = y1(i) + v1(i) * dt; % 更新物体1的位置
end
end
% 绘制结果
figure;
plot(t, y1, 'b-', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Position (m)');
title('Single kid on a trampoline');
legend('Object 1');
grid on;