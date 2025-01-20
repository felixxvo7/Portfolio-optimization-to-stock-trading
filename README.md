# Portfolio Optimization Project

This project is **portfolio optimization** for stock trading, combining both theoretical and practical approaches using financial models and optimization algorithms in mathematics. It focuses on two core financial strategies:

1. **Mean-Variance Analysis & CAPM**: Traditional models to balance risk and return. In this project, we use SHARPE ratio and CAPM both constrained and unconstrained.
2. **Enhanced Index Tracking Portfolio**: A more advanced way to track a benchmark index and aim for better returns.

From the theoretical explanations in the paper to the MATLAB code implementation, we explore how these models work to optimize stock portfolios.

---

## What This Project Does

### Paper Highlights
- **Background**:
  - Inflation is high, and investments overcome the problem.
  - The Capital Asset Pricing Model (CAPM) and mean-variance analysis are discussed in depth.
  - A new method, **Enhanced Index Tracking**, is introduced to track and beat benchmark indices (like S&P 500).
- **Methods**:
  - CAPM estimates expected returns based on risk and market trends.
  - Enhanced Index Tracking minimizes tracking error while improving returns.
- **Tools Used**:
  - Quadratic programming and optimization algorithms.
  - Theoretical formulas for portfolio weights and variance.
  - Both uses MATLAB to analyze and visualize.
- **Experiments**:
  - Real US stock data collected from Yahoo Finance.
  - Comparison of traditional vs. enhanced methods.

### Code Breakdown
- **Tools Used**: MATLAB with Financial Toolbox.
- **What It Does**:
  - Reads historical stock prices and calculates daily returns.
  - Uses optimization to find the best asset weights for portfolios.
  - Visualizes the results: Efficient Frontier, risks, returns, and portfolio value changes over time.

- **Key Features**:
  1. **Efficient Frontier**: Visualizes the trade-off between risk and return.
  2. **Enhanced Index Tracking**: Tracks a benchmark index while aiming for better returns.
  3. **Portfolio Simulations**: Compares enhanced vs. traditional portfolios over time.

---

## File Descriptions

### Paper:
- `Optimization (8).pdf`:
  - A detailed report explaining the theory and results.
  - Includes CAPM, Mean-Variance Analysis, and Enhanced Index Tracking Portfolio methods.

### Code:
#### 1. Core MATLAB Scripts
- **Portfolio Optimization**:
  - Reads stock data from CSV.
  - Sets up the portfolio with a risk-free rate.
  - Calculates weights for maximum Sharpe ratio.
  - Plots the efficient frontier.
- **Enhanced Index Tracking**:
  - Solves for optimal portfolio weights while tracking the benchmark.
  - Uses optimization (`fmincon`) to minimize tracking error and maximize returns.

#### 2. Simulation Code
- Simulates portfolio values over time.
- Plots a comparison between enhanced tracking and non-tracking portfolios.

#### 3. Data Files
- `stock_data.csv`: Contains historical stock prices.
- `stock_old_data.csv`: Another dataset for benchmarking.

## Authors
- **Felix Vo** (7924848)
- **Ha Uyen Tran** (7901093)
