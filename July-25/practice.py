"""
print("hello world")

name = input("whats ur name?")
print(f"Hello, {name}!")   #more popular
print("Hello, " +name+ "!")

#declaring a string
ch="Hello anbu"

#Accessing characters
print(ch[0])      #H
print(ch[-1])     #r

#Slicing
print(ch[0:5])    #Hello
print(ch[7:])     #nbu

#String methods
print(ch.upper())
print(ch.lower())
print(ch.replace("anbu","dharshh"))

#Data structure  LIST
#Declaring a list
fruits = ["apple","banana","cherry"]

#Accessing elements
print(fruits[1])

#Adding elements
fruits.append("orange")
print(fruits)

#Removing elements
fruits.remove("banana")
print(fruits)

#Slicing to print all elements
print(fruits[1:])

#Looping
for i in fruits:
    print(i)

#------------------- TUPLE [immutable] -------------------------
c = ("red", "green","blue")
#accessing elements
print(c[0])          #red

#Slicing
print(c[1:3])        #green,blue

#tuple is IMMUTABLE
#c[0]="yellow"

#------------------------ EXERCISE -----------------------

string= "The Lion King"
print(string[4:8])

food= ["briyani","noodles","sandwich","icecream"]
print(food.append("fried rice"))
print(food)

print(food.remove("noodles"))
print(food)

n=(1,2,3)

print(n[2])

#------------------------ CONDITIONAL -----------------
age=int(input("Enter your age:"))

if age>=18:
    print("you can vote")
else:
    print("too young")

marks = int(input("enter ur mark"))

if marks>=90:
    print("A")
elif marks>=75:
    print("B")
elif marks>=50:
    print("C")
else:
    print("F")

count=1

while count<=5:
    print("count is", count)
    count+=1

#--------------------------- RANGE ------------------------
for i in range(5):
    print("number",i)

for i in range(1,6):
    print(i)

for i in range(1,10):
    if i == 5:
        continue
    if i==8:
        break
    print(i)

#------------------------- EXERCISE -----------------------
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

#---------------------------- FUNCTIONS ----------------------
def greet():
    print("Hello from hexaware")
greet()

#with parameters
def greet(name):
    print(f"Hello, {name}! Welcome")

greet("user")

#---------------------------------- USER DEFINED FUNCTIONS -------------------------
def add(a,b):
    return a+b

result=add(10,5)
print("sum is:", result)
#----------------------------------
def power(base,exponent=2):
    return base ** exponent

print(power(5))
print(power(5,3))

#--------------------------- PREDEFINED FUNCTIONS -----------------------------
name ="anbu"
print(len(name))

print(type(5))
print(type("Hello"))

age ="12"
print(int(age)+5)

num=[5,9,3]
print(sum(num))
print(max(num))
print(min(num))

names=["Zara", "Admin", "Line"]
print(sorted(names))

print(abs(-9))     #9

print(round(3.75))         #4
print(round(3.7567,2))     #3.76

#------------------------------------- MODULE --------------------
#module is a COLLECTION OF FUNCTIONS
import math
print(math.sqrt(16))
print(math.pow(2,3))
print(math.pi)

#-----------------------------------------------
import datetime as d
today = d.date.today()
print("Todays date: ",today)

now=d.datetime.now()
print("Current time is:", now.strftime("%H:%M:%S"))

#main.py
import mymath
print("Addition:", mymath.add(10,5))
print("Multiplication:", mymath.multiply(4,3))
print("Subtraction",mymath.sub(9,4))
print("Divide",mymath.div(10,5))
"""
from mypackage.calc import add, subtract
from mypackage.string_utils import shout,whisper

print(add(2,3))
print(shout("hello"))
