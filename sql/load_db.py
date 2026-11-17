import sqlite3, pandas as pd
con = sqlite3.connect("data/customers.db")
pd.read_csv("data/clean/cleaned_sales.csv", dtype={"InvoiceNo": str, "CustomerID": str}).to_sql("sales", con, if_exists="replace", index=False)
pd.read_csv("data/clean/customers.csv", dtype={"CustomerID": str}).to_sql("customers", con, if_exists="replace", index=False)
con.close(); print("done")