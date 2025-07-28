# Q1. Write a function Q1. Write a function is_prime(n) is_prime(n) that returns  that returns True True if  if n n is a prime number, else  is a prime number, else False False.
def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(n**0.5)+1):
        if n % i == 0:
            return False
    return True

n = int(input("Enter a number to check if it's prime: "))
if is_prime(n):
    print(f"The number {n} is prime.")
else:
    print(f"The number {n} is not a prime.")

# Q2.  Checks if it's a palindrome

s = input("\nEnter a string: ")
rev = s[::-1]
print(f"Reversed string: {rev}")
if s == rev:
    print("It is a palindrome.")
else:
    print("It is not a palindrome.")

# Q3. List: Remove duplicates, sort, print second largest
num_list = list(map(int, input("\nEnter numbers separated by space: ").split()))
unique_sorted = sorted(set(num_list))
print("Sorted without duplicates:", unique_sorted)
if len(unique_sorted) >= 2:
    print("Second largest:", unique_sorted[-2])
else:
    print("Not enough unique elements.")

# Q4. Person and Employee classes with method overriding
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def display(self):
        print(f"Name: {self.name}, Age: {self.age}")

class Employee(Person):
    def __init__(self, name, age, emp_id, dept):
        super().__init__(name, age)
        self.emp_id = emp_id
        self.dept = dept

    def display(self):
        print(f"Name: {self.name}, Age: {self.age}, ID: {self.emp_id}, Department: {self.dept}")

print("\nEnter Employee details:")
name = input("Name: ")
age = int(input("Age: "))
emp_id = input("Employee ID: ")
dept = input("Department: ")

emp = Employee(name, age, emp_id, dept)
emp.display()

# Q5. Method overriding example: Vehicle -> Car
class Vehicle:
    def drive(self):
        print("Driving a vehicle")

class Car(Vehicle):
    def drive(self):
        print("Driving a car smoothly")

print("\nMethod Overriding Example:")
v = Vehicle()
v.drive()
c = Car()
c.drive()

# Q6. Read students.csv, fill missing values, save cleaned
import pandas as pd
import numpy as np

print("\nReading and cleaning students.csv")
df = pd.read_csv("students.csv")
print("Old data\n",df)
df['Age'] = df['Age'].fillna(df['Age'].mean())
df['Score'] = df['Score'].fillna(0)
df.to_csv("students_cleaned.csv", index=False)
print("students_cleaned.csv saved.")
print("Modifided data\n", df)

# Q7. Convert cleaned CSV to JSON
import pandas as pd
print("\nConverting cleaned CSV to JSON")
df_cleaned = pd.read_csv("students_cleaned.csv")
df_cleaned.to_json("students.json", orient='records', indent=4)
print("students.json saved.")

# Q8. Add Status and Tax_ID columns
import pandas as pd
print("\nData transformation using Pandas and NumPy...")
df = pd.read_csv("students_cleaned.csv")
def status(score):
    if score >= 85:
        return 'Distinction'
    elif score >= 60:
        return 'Passed'
    else:
        return 'Failed'

df['Status'] = df['Score'].apply(status)
df['Tax_ID'] = df['ID'].apply(lambda x: f"TAX-{x}")
df.to_csv("students_transformed.csv", index=False)
print("students_transformed.csv saved with Status and Tax_ID.")

# Q9. Read products.json, increase price by 10%, save updated
import json

print("\nUpdating product prices...")
with open("products.json") as f:
    products = json.load(f)

for product in products:
    product['price'] = round(product['price'] * 1.10, 2)

with open("products_updated.json", "w") as f:
    json.dump(products, f, indent=4)

print("products_updated.json saved with updated prices.")


