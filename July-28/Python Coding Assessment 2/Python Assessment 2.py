# Q1. Write a Python function factorial(n) using a loop (no math.factorial).
def factorial(n):
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result

num = int(input("Enter a number to calculate factorial: "))
print(f"Factorial of {num} is {factorial(num)}")

# Q2. From a list of (name, score) tuples, print names scoring above 75 and average score.
students = [("Aarav", 80), ("Sanya", 65), ("Meera", 92), ("Rohan", 55)]
print("Students scoring above 75:")
for name, score in students:
    if score > 75:
        print(name)
average = sum(score for _, score in students) / len(students)
print("Average score:", average)

# Q3. Create BankAccount class with deposit and withdraw; raise exception if overdrawn.
class BankAccount:
    def __init__(self, holder_name, balance=0):
        self.holder_name = holder_name
        self.balance = balance

    def deposit(self, amount):
        self.balance += amount
        print(f"Deposited {amount}. New balance is {self.balance}")

    def withdraw(self, amount):
        if amount > self.balance:
            raise ValueError("Insufficient balance.")
        self.balance -= amount
        print(f"Withdrawn {amount}. Remaining balance is {self.balance}")

# Sample test
account = BankAccount("Aarav", 1000)
account.deposit(500)
account.withdraw(300)

# Q4. Create SavingsAccount class inheriting BankAccount with interest_rate and apply_interest().
class SavingsAccount(BankAccount):
    def __init__(self, holder_name, balance=0, interest_rate=0.05):
        super().__init__(holder_name, balance)
        self.interest_rate = interest_rate

    def apply_interest(self):
        interest = self.balance * self.interest_rate
        self.balance += interest
        print(f"Interest applied. New balance is {self.balance}")

# Sample test
savings = SavingsAccount("Sanya", 1000, 0.10)
savings.apply_interest()

# Q5. Clean orders.csv using pandas: fill missing values, compute TotalAmount, save to new CSV.
import pandas as pd

df = pd.read_csv("orders.csv")
print("Old data:\n",df)
df['CustomerName'] = df['CustomerName'].fillna('Unknown')
df['Quantity'] = df['Quantity'].fillna(0)
df['Price'] = df['Price'].fillna(0)
df.to_csv("orders_cleaned.csv", index=False)
print("Cleaned CSV saved as orders_cleaned.csv")
print("Modified Data:\n",df)

# Q6. Read inventory.json, add 'status' field based on stock, save to inventory_updated.json.
import json
with open("inventory.json", "r") as f:
    inventory = json.load(f)

for item in inventory:
    item['status'] = 'In Stock' if item['stock'] > 0 else 'Out of Stock'

with open("inventory_updated.json", "w") as f:
    json.dump(inventory, f, indent=2)

print("Updated inventory saved to inventory_updated.json")

# Q7. Generate 20 random scores (35-100),count >75,compute mean & std, save as scores.csv.
import numpy as np
import pandas as pd

scores = np.random.randint(35, 101, 20)
count_above_75 = np.sum(scores > 75)
mean_score = np.mean(scores)
std_dev = np.std(scores)

print("Scores:", scores)
print("Count above 75:", count_above_75)
print("Mean:", mean_score)
print("Standard Deviation:", std_dev)

df_scores = pd.DataFrame({'Score': scores})
df_scores.to_csv("scores.csv", index=False)
print("Scores saved to scores.csv")