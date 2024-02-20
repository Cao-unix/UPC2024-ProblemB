% 定义常数和参数
g = 9.8; % 重力加速度
Pi = 3.14;
k = 96000; % 弹簧劲度系数
R = 5;
N = 60;
y0 = 0.0; % 初始时间
yf = 0.5; % 结束时间
dy = 0.001; % 时间步长
% 初始化数组
y = y0:dy:yf;
n = length(y);
F = zeros(1, n); % 物体1的位置
for i = 1:n
F(i) = N*k*(sqrt(R*R+y(i)*y(i))-R)*y(i)/sqrt(R*R+y(i)*y(i)); % 弹簧力
end
cftool(y,F);