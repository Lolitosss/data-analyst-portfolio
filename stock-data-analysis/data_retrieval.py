import yfinance as yf
import pandas as pd

def get_and_save_raw_data(ticker, period="1y"):
    try:
        data = yf.download(ticker, period=period)

        if data.empty:
            print(f"No data found for {ticker}. Check the ticker symbol.")
            return False
        

        filename = f"{ticker}_raw.csv"
        data.to_csv(filename, index=True)
        print(f"Raw data for {ticker} saved to {filename}")

        #print(f"First 10 rows of {ticker} raw data:\n{data.head(10)}")

        return data

    except Exception as e:
        print(f"Error downloading or saving data for {ticker}: {e}")
        return False