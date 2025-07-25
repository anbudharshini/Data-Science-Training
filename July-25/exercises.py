#------------------------------------ EXERCISE 1 ---------------------------
"""
string= "The Lion King"
print(string[4:8])

food= ["briyani","noodles","sandwich","icecream"]
print(food.append("fried rice"))
print(food)

print(food.remove("noodles"))
print(food)

n=(1,2,3)

print(n[2])

#---------------------------------- EXERCISE 2 ---------------------------------
#1. FizzBuzz Challenge
for i in range(1, 51):
    if i % 3 == 0 and i % 5 == 0:
        print("FizzBuzz")
    elif i % 3 == 0:
        print("Fizz")
    elif i % 5 == 0:
        print("Buzz")
    else:
        print(i)

#2. Login Simulation
correct_username = "admin"
correct_password = "1234"

for attempt in range(3):
    username = input("Enter username: ")
    password = input("Enter password: ")
    if username == correct_username and password == correct_password:
        print("Login successful!")
        break
    else:
        print("Incorrect credentials.")
else:
    print("Account Locked")

#3. Palindrome Checker
word = input("Enter a word: ")
if word == word[::-1]:
    print("Palindrome")
else:
    print("Not a palindrome")

#4. Prime Numbers in a Range
n = int(input("Enter a number: "))
print("Prime numbers:")
for num in range(2, n + 1):
    for i in range(2, int(num ** 0.5) + 1):
        if num % i == 0:
            break
    else:
        print(num, end=" ")

#5. Star Pyramid
n = int(input("Enter number of rows: "))
for i in range(1, n + 1):
    print("*" * i)

#6. Sum of Digits
num = input("Enter a number: ")
total = sum(int(digit) for digit in num)
print("Sum of digits:", total)

#7. Multiplication Table Generator
num = int(input("Enter a number: "))
for i in range(1, 11):
    print(f"{num} x {i} = {num * i}")

#8. Count Vowels in a String
sentence = input("Enter a sentence: ")
vowels = "aeiouAEIOU"
count = sum(1 for char in sentence if char in vowels)
print("Number of vowels:", count)

#------------------------------------ EXERCISE 3 -------------------------------
#1. BMI Calculator
import math

def calculate_bmi(weight, height):
    bmi = weight / math.pow(height, 2)
    if bmi < 18.5:
        return "Underweight"
    elif bmi <= 24.9:
        return "Normal"
    else:
        return "Overweight"

w = float(input("Enter weight (kg): "))
h = float(input("Enter height (m): "))
print("You are:", calculate_bmi(w, h))

#2. Strong Password Checker
while True:
    pwd = input("Enter password: ")
    if(any(c.isupper() for c in pwd) and any(c.isdigit() for c in pwd) and
        any(c in "!@#$%^&*()" for c in pwd)):
        print("Strong password!")
        break
    else:
        print("Password must contain uppercase, number, and special character.")

#3. Weekly Expense Calculator
expenses = []
for i in range(7):
    amt = float(input(f"Enter expense for day {i+1}: "))
    expenses.append(amt)

def show(data):
    print("Total:", sum(data))
    print("Average per day:", sum(data)/len(data))
    print("Highest spend:", max(data))

show(expenses)

#4. Guess the Number
import random
secret = random.randint(1, 50)

for i in range(5):
    guess = int(input("Guess the number (1–50): "))
    if guess == secret:
        print("Correct!")
        break
    elif guess < secret:
        print("Too Low")
    else:
        print("Too High")
else:
    print("Out of tries! Number was:", secret)

#Student Report Card
import datetime

def grade(avg):
    if avg >= 90:
        return "A"
    elif avg >= 75:
        return "B"
    else:
        return "C"

name = input("Enter student name: ")
marks = [int(input(f"Enter mark {i+1}: ")) for i in range(3)]
total = sum(marks)
avg = total / 3

print("Date:", datetime.date.today())
print("Total:", total)
print("Average:", avg)
print("Grade:", grade(avg))

#6. Contact Saver
contacts = {}

while True:
    print("\n1. Add Contact\n2. View Contacts\n3. Save & Exit")
    choice = input("Enter choice: ")

    if choice == "1":
        name = input("Name: ")
        phone = input("Phone: ")
        contacts[name] = phone
    elif choice == "2":
        for name, phone in contacts.items():
            print(f"{name} : {phone}")
    elif choice == "3":
        with open("contacts.txt", "w") as f:
            for name, phone in contacts.items():
                f.write(f"{name}:{phone}\n")
        print("Contacts saved.")
        break
    else:
        print("Invalid option.")
"""
