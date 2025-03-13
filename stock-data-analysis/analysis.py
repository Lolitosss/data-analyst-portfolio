import pandas as pd
import matplotlib.pyplot as plt

def analyze_returns_volatility(combined_df, ticker):
    """Analyzes returns and volatility of a stock with Y-axis labels."""

    data = combined_df[combined_df['Ticker'] == ticker].copy()

    data['Daily_Return'] = data['Close'].pct_change()
    data['Cumulative_Return'] = (1 + data['Daily_Return']).cumprod() - 1
    data['Volatility'] = data['Daily_Return'].rolling(window=20).std()

    # Plotting
    plt.figure(figsize=(15, 10))

    # Daily Returns
    plt.subplot(3, 1, 1)
    plt.plot(data['Daily_Return'], label='Daily Returns')
    plt.title(f'{ticker} Daily Returns')
    plt.ylabel('Percentage Change') 
    plt.legend()

    # Cumulative Returns
    plt.subplot(3, 1, 2)
    plt.plot(data['Cumulative_Return'], label='Cumulative Returns')
    plt.title(f'{ticker} Cumulative Returns')
    plt.ylabel('Cumulative Percentage Return') 
    plt.legend()

    # Volatility
    plt.subplot(3, 1, 3)
    plt.plot(data['Volatility'], label='Volatility (20-day Rolling Std Dev)')
    plt.title(f'{ticker} Volatility')
    plt.ylabel('Standard Deviation of Daily Returns') 
    plt.legend()

    plt.tight_layout()
    plt.show()

    # Statistical Insights
    print(f"\nAnalysis for {ticker}:")
    print(f"Average Daily Return: {data['Daily_Return'].mean():.4f}")
    print(f"Standard Deviation of Daily Returns: {data['Daily_Return'].std():.4f}")

def calculate_final_cumulative_return(combined_df, ticker):
    data = combined_df[combined_df['Ticker'] == ticker].copy()
    
    data['Daily_Return'] = data['Close'].pct_change()
    data['Cumulative_Return'] = (1 + data['Daily_Return']).cumprod() - 1
    
    return data['Cumulative_Return'].iloc[-1]

def display_summary_statistics(combined_df, tickers):
    statistics = []
    
    for ticker in tickers:
        data = combined_df[combined_df['Ticker'] == ticker].copy()
        data['Daily_Return'] = data['Close'].pct_change()
        data['Volatility'] = data['Daily_Return'].rolling(window=20).std()
        statistics.append({
            'Ticker': ticker,
            'Average Daily Return': data['Daily_Return'].mean(),
            'Volatility': data['Volatility'].mean(),
            'Final Cumulative Return': calculate_final_cumulative_return(combined_df, ticker)
        })
    df_statistics = pd.DataFrame(statistics)
    
    print("\nSummary Statistics:")
    print(df_statistics)

def overlay_cumulative_returns(combined_df, tickers):
    plt.figure(figsize=(15, 5))
    
    for ticker in tickers:
        data = combined_df[combined_df['Ticker'] == ticker].copy()
        data['Daily_Return'] = data['Close'].pct_change()
        data['Cumulative_Return'] = (1 + data['Daily_Return']).cumprod() - 1
        plt.plot(data.index, data['Cumulative_Return'], label=f'{ticker} Cumulative Returns')
   
    plt.title('Cumulative Returns Comparison')
    plt.xlabel('Date')
    plt.ylabel('Cumulative Percentage Return')
    plt.legend()
    plt.grid(True)
    plt.show()