import matplotlib.pyplot as plt
import pandas as pd

def plot_adj_close(combined_df, tickers):
    plt.figure(figsize=(12, 6))

    for ticker in tickers:
        print(ticker)
        ticker_data = combined_df[combined_df['Ticker'] == ticker]
        plt.plot(ticker_data.index, ticker_data['Close'], label=ticker)
    
    plt.xlabel("Date")
    plt.ylabel("Close Price")
    plt.title("Stock Prices Over Time")
    plt.legend()
    plt.grid(True)
    plt.savefig("stock_prices.png")
    plt.show()