
% Load historical price data
data2 = readtable('C:\Users\IRIS\Downloads\stock_data.csv'); % replace with your file name

% Define the stock tickers and benchmark index ticker
tickers = {'AAPL', 'MSFT', 'AMZN', 'GOOGL', 'TSLA', 'x_GSPC'};

% Extract the closing prices of the stocks and benchmark index
prices = data2{:, tickers};

% Calculate the returns
returns = price2ret(prices);

% Calculate the expected returns using the sample mean
exp_returns = mean(returns);

% Calculate the covariance matrix
cov_mat = cov(returns);

% Define the number of assets and the benchmark index
n = length(tickers) - 1; % exclude the benchmark index
B = n + 1; % the last asset is the benchmark index

% Define the expected return and variance of the benchmark index
exp_return_benchmark = exp_returns(B);
variance_benchmark = cov_mat(B, B);

% Define the parameter values for the objective function
g = 1; % adjust as needed
epsilon = 0.1; % adjust as needed

% Define the constraints
Aeq = ones(1, n);
beq = 1;
lb = zeros(n, 1);
ub = ones(n, 1);
w0 = ones(n, 1) / n;
obj_val = f(w);

% Define the enhanced index tracking problem
f = @(w) g * (w(1:n).' * cov_mat(1:n, 1:n) * w(1:n) - 2 * w(1:n).' * cov_mat(1:n, n)) - epsilon * (w(1:n).'* exp_returns(1:n).' - exp_return_benchmark);

%w0 = ones(n, 1) / n;
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point', 'MaxFunctionEvaluations', 10000, 'MaxIterations', 10000);
[~, fval] = fmincon(f, w0, [], [], Aeq, beq, lb, ub, [], options);

% Define the normal index tracking problem
g = @(w) g * (w(1:n).' * cov_mat(1:n,1:n)*w(1:n)) - epsilon * (w(1:n).'*exp_returns(1:n).');

options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point', 'MaxFunctionEvaluations', 10000, 'MaxIterations', 10000);
[w, gval] = fmincon(g, w0, [], [], Aeq, beq, lb, ub, [], options);

%
% Input data
T = 64; % number of time periods
X0 = 100; % initial portfolio value

% Optimization parameters
gamma = 1; % risk aversion parameter
alpha = 0.95; % tracking error bound
w_tilde = ones(n, 1)/n; % initial portfolio weights for no-tracking portfolio

% Calculate optimal portfolio weights
Sigma = cov(returns(1:n)); % covariance matrix
mu = mean(returns(1:n))'; % expected returns
R = returns(1:n);
w_star = fmincon(f, w0, [], [], Aeq, beq, lb, ub, [], options); % optimal portfolio weights for tracking portfolio
w_tilde_star = fmincon(g, w0, [], [], Aeq, beq, lb, ub, [], options); % optimal portfolio weights for no-tracking portfolio

% Simulate portfolio values over time
X_star = X0*ones(T+1, 1); % tracking portfolio values
X_tilde = X0*ones(T+1, 1); % no-tracking portfolio values
for t = 1:T
    % Calculate portfolio values for tracking portfolio
    R_star = R';
    X_star(t+1) = (1 + R_star'*w_star)*X_star(t);
    
    % Calculate portfolio values for no-tracking portfolio
    R_tilde = R';
    X_tilde(t+1) = (1 + R_tilde'*w_tilde_star)*X_tilde(t);
end


% Plot portfolio values over time
figure;
plot(0:T, X_star, 'b-', 'LineWidth', 2);
hold on;
plot(0:T, X_tilde, 'r-', 'LineWidth', 2);
legend('Tracking portfolio', 'No-tracking portfolio');
xlabel('Time');
ylabel('Portfolio value');
title('Portfolio values over time');

