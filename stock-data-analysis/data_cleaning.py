import pandas as pd
import numpy as np
from pandas.api.types import is_numeric_dtype

def clean_data(df):
    if df is None:
        return None

    # 1. Missing Values:
    df.ffill(inplace=True)
    df.bfill(inplace=True)
    df.dropna(inplace=True)

    # 2. Outliers:
    for col in ['Open', 'High', 'Low', 'Close', 'Volume']:
        if col in df.columns:
            if isinstance(df.columns, pd.MultiIndex): 
                for ticker in df.columns.get_level_values(1).unique(): 
                    if (col, ticker) in df.columns:
                        Q1 = df[(col, ticker)].quantile(0.25)
                        Q3 = df[(col, ticker)].quantile(0.75)
                        IQR = Q3 - Q1
                        lower_bound = Q1 - 1.5 * IQR
                        upper_bound = Q3 + 1.5 * IQR
                        df = df[((df[(col, ticker)] >= lower_bound) & (df[(col, ticker)] <= upper_bound))]
            else:
                Q1 = df[col].quantile(0.25)
                Q3 = df[col].quantile(0.75)
                IQR = Q3 - Q1
                lower_bound = Q1 - 1.5 * IQR
                upper_bound = Q3 + 1.5 * IQR
                df = df[(df[col] >= lower_bound) & (df[col] <= upper_bound)]

    # 3. Duplicates:
    df.drop_duplicates(inplace=True)

    # 4. Inconsistent Data Types:
    for col in ['Open', 'High', 'Low', 'Close', 'Volume']:
        if col in df.columns:
            if isinstance(df.columns, pd.MultiIndex):
                for ticker in df.columns.get_level_values(1).unique():
                    if (col, ticker) in df.columns:
                        if not is_numeric_dtype(df[(col, ticker)]):
                            try:
                                df[(col, ticker)] = pd.to_numeric(df[(col, ticker)], errors='coerce')
                            except Exception as e:
                                print(f"Error converting column {col} for ticker {ticker}: {e}")
                                return None
            else:
                if not is_numeric_dtype(df[col]):
                    try:
                        df[col] = pd.to_numeric(df[col], errors='coerce')
                    except Exception as e:
                        print(f"Error converting column {col}: {e}")
                        return None

    # 5. Range Checks:
    if 'Volume' in df.columns:
        if isinstance(df.columns, pd.MultiIndex):
            for ticker in df.columns.get_level_values(1).unique():
                if ('Volume', ticker) in df.columns:
                    df = df[df[('Volume', ticker)] >= 0]
        else:
            df = df[df['Volume'] >= 0]

    return df