% Read stock data from CSV file
data_stocks = readtable('C:\Users\felix\Downloads\stock_data.csv');

% Extract stock symbols from the table
symbol = data_stocks.Properties.VariableNames(2:end);

% Calculate daily returns from the stock data
dailyReturn = tick2ret(data_stocks{:,2:end});

% Create a portfolio object with asset list and risk-free rate
p = Portfolio('AssetList', symbol, 'RiskFreeRate', 0.01/252);

% Set default constraints for the portfolio
p = setDefaultConstraints(p);

% Estimate mean and covariance of asset returns
p = estimateAssetMoments(p, dailyReturn);

% Estimate weights for maximum Sharpe ratio portfolio
w1 = estimateMaxSharpeRatio(p);

% Estimate risk and return of the optimal portfolio
[risk1, ret1] = estimatePortMoments(p, w1);

% Create a figure for plotting
f = figure;
tabgp = uitabgroup(f); % Define tab group

% Tab 1: Efficient Frontier Plot
tab1 = uitab(tabgp, 'Title', 'Efficient Frontier Plot'); % Create tab
ax = axes('Parent', tab1);
[m, cov] = getAssetMoments(p);
scatter(ax, sqrt(diag(cov)), m, 'oc', 'filled');
xlabel('Risk')
ylabel('Expected Return')
text(sqrt(diag(cov))+0.0003, m, symbol, 'FontSize', 7);
hold on;
[risk2, ret2] = plotFrontier(p, 10);
plot(risk1, ret1, 'p', 'markers', 15, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'y');
hold off

% Tab 2: Optimal Portfolio Weight Table
tab2 = uitab(tabgp, 'Title', 'Optimal Portfolio Weight'); % Create tab

% Define table column names and formats
columnname = {'Ticker', 'Weight (%)'};
columnformat = {'char', 'numeric'};

% Extract data for table display
data = table2cell(table(symbol(w1 > 0), w1(w1 > 0) * 100));

% Create and populate the uitable
uit = uitable(tab2, 'Data', data, 'ColumnName', columnname, 'ColumnFormat', columnformat, 'RowName', []);

% Set table width and height
uit.Position(3) = 450; % Width
uit.Position(4) = 350; % Height