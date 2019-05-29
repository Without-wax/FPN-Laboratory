for i=1:3
    [p(i,:),r(i,:),f(i,:),v(i,:)] = retrial(i);
end
i=[0.9996 1 1.0008];
%Plot frequency
plot(i,f,'-diamond','linewidth',1.5);
grid
xticks([0.9996 1 1.0008])
xticklabels({'(0.9996)','(1)','(1.0008)'})
y = [48 52];
ylim(y); % current y-axis limits
xlabel('w0 p.u')
ylabel('Frequency (Hz)')
title('System Frequency')
ax = gca;
ax.FontSize = 20;
ax.FontName = 'Times';
set(gcf, 'Color', 'w');
export_fig Q6/w0/f3.png

%Voltage Plot
figure
plot(i,v(:,1),'-diamond','linewidth',1.5)
xticks([0.9996 1 1.0008])
xticklabels({'(0.9996)','(1)','(1.0008)'})
hold on
plot(i,v(:,2),'-diamond')
plot(i,v(:,3),'-diamond')
hold off
xlabel('w0 p.u')
ylabel('Voltage at Nodes (V)')
title('Node Voltages')
legend('V1','V2','V3')
grid
ax = gca;
ax.FontSize = 20;
ax.FontName = 'Times';
set(gcf, 'Color', 'w');
export_fig Q6/w0/v3.png

%Active Power Plot
figure
plot(i,p(:,1),'-diamond','linewidth',1.5)
hold on
plot(i,p(:,2),'-diamond','linewidth',1.5)
plot(i,p(:,3),'-diamond','linewidth',1.5)
xticks([0.9996 1 1.0008])
xticklabels({'(0.9996)','(1)','(1.0008)'})
hold off
y = [0 5e3];
ylim(y); % current y-axis limits
xlabel('w0 p.u')
ylabel('Active Power (W)')
title('Pg')
legend('P1','P2','P3')
grid
ax = gca;
ax.FontSize = 20;
ax.FontName = 'Times';
set(gcf, 'Color', 'w');
export_fig Q6/w0/p3.png

%Reactive Power Plot
figure
plot(i,r(:,1),'-diamond','linewidth',1.5)
hold on
plot(i,r(:,2),'-diamond','linewidth',1.5)
plot(i,r(:,3),'-diamond','linewidth',1.5)
xticks([0.9996 1 1.0008])
xticklabels({'(0.9996)','(1)','(1.0008)'})
hold off
xlabel('w0 p.u')
ylabel('Reactive Power (Var)')
title('Qg')
legend('Q1','Q2','Q3')
grid
ax = gca;
ax.FontSize = 20;
ax.FontName = 'Times';
set(gcf, 'Color', 'w');
export_fig Q6/w0/q3.png