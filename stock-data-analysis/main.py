from data_retrieval import get_and_save_raw_data
from data_cleaning import clean_data
from plotting import plot_adj_close
import analysis


def get_tickers_from_input():
    while True:
        tickers_input = input("Enter up to four stock tickers (comma-separated, or 'exit' to quit): ").upper()
        if tickers_input.lower() == 'exit':
            return None

        tickers = [t.strip() for t in tickers_input.split(",")]
        if 0 < len(tickers) <= 4:
            return tickers
        else:
            print("Please enter between 1 and 4 tickers.")

tickers = get_tickers_from_input()

if tickers:
    multi_data = get_and_save_raw_data(tickers)
    cleaned_data = clean_data(multi_data)
    if cleaned_data is not None:
       
        combined_df = cleaned_data.copy()
        combined_df = combined_df.stack(level=1)
        combined_df.index.names = ['Date', 'Ticker']
        combined_df = combined_df.reset_index(level=1)

        print(combined_df.head())

        plot_adj_close(combined_df, tickers)

        for ticker in tickers:
            analysis.analyze_returns_volatility(combined_df, ticker)

        final_returns = {}
        for ticker in tickers:
            final_returns[ticker] = analysis.calculate_final_cumulative_return(combined_df, ticker)

        best_ticker = max(final_returns, key=final_returns.get)
        print(f"\nThe best performing stock was: {best_ticker} with a cumulative return of {final_returns[best_ticker]:.4f}")

        analysis.display_summary_statistics(combined_df, tickers)
        analysis.overlay_cumulative_returns(combined_df, tickers)

    else:
        print("No valid data to process.")