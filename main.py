import warnings
import pandas as pd
import matplotlib.pyplot as plt

import mysql.connector
db = mysql.connector.connect(
    host = "127.0.0.1",
    user = "root",
    password = "Osanaoimafidon305",
    database = "Food Delivery Service"
)

cursor = db.cursor()
print('connected:', db)


# Suppress specific warning
#warnings.filterwarnings("ignore", category=UserWarning, message="pandas only supports SQLAlchemy connectable")

# Query 1: Popular Times for Orders
def get_order_times():
    query = """
    SELECT HOUR(`Order`.order_date) AS order_hour, 
           COUNT(`Order`.order_id) AS order_count
    FROM `Order` 
    GROUP BY order_hour
    ORDER BY order_hour;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    return pd.DataFrame(result, columns=['Order Hour', 'Order Count'])

# Fetch the data
order_times = get_order_times()

# Plotting the bar chart
plt.figure(figsize=(10,6))
plt.bar(order_times['Order Hour'], order_times['Order Count'], color='skyblue')
plt.xlabel('Hour of the Day')
plt.ylabel('Number of Orders')
plt.title('Popular Times for Orders')
plt.xticks(order_times['Order Hour'])  # Show each hour on the x-axis
plt.grid(True)
plt.tight_layout()
plt.show()


# Query 2: Most Popular Restaurants
def get_most_popular_restaurants():
    query = """
    SELECT Restaurant.restaurant_id, Restaurant.name, COUNT(`Order`.order_id) AS order_count
    FROM `Order`
    JOIN Restaurant ON `Order`.restaurant_id = Restaurant.restaurant_id
    GROUP BY Restaurant.restaurant_id, Restaurant.name
    ORDER BY order_count DESC
    LIMIT 5;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    return pd.DataFrame(result, columns=['Restaurant ID', 'Restaurant Name', 'Order Count'])

# Fetch the data
popular_restaurants = get_most_popular_restaurants()

# Plotting the bar chart
plt.figure(figsize=(10,6))
plt.bar(popular_restaurants['Restaurant Name'], popular_restaurants['Order Count'], color='lightgreen')
plt.xlabel('Restaurant')
plt.ylabel('Number of Orders')
plt.title('Most Popular Restaurants')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()


# Close the cursor and connection
cursor.close()
db.close()
