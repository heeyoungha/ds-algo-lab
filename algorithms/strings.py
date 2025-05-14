print(f"=== 📘 문자열 포맷팅 방식 ===")

name = "Tom"
age = 20

# f-string
print(f"내 이름은 {name}, 나는 {age}살 입니다")

# format()
print("내 이름은 {name}, 나는 {age}살 입니다".format(name="Tom", age=20))

# % 연산자
print("내 이름은 %s, 나는 %d살 입니다" % ("Tom", 20))

print("")
print(f"=== 📘 문자열 자르기 ===")
"""문자열을 리스트처럼 접근"""
code = "asdk_eye"
last_four_words = code[-4:]

print(f"마지막 4글자 : {last_four_words}")

print("")
print(f"=== 📘 문자열 섞기 ===")

str1 = "aaaaa"
str2 = 	"bbbbb"
answer = ''
for i in range(len(str1)):
        answer += str1[i]
        answer += str2[i]
print(answer)

print("")
print(f"=== 📘 문자열 곱하기 ===")

my_string = "str"
k = 2
answer = my_string * k
print(answer)

print("")
print(f"=== 📘 큰 수로 합치기 ===")

a = 9
b = 12
try1 = str(a) + str(b)
try2 = str(b) + str(a)
if try1 >= try2:
    answer = try1
else:
    answer = try2
print(int(answer))

"""f-string으로 바로 변환 후 max() 비교"""
"""max() : 같은 값을 비교시 앞의 값을 반환"""
print( max(int(f"{a}{b}"), int(f"{b}{a}")) )

"""문자열로 형변환 후 max() 비교"""
a, b = str(a), str(b)
print( max(int(a + b), int(b + a)) )

print("")
print(f"=== 📘 대소문자 ===")

text1 = "HELLO"
text2 = "hello"
text3 = "Python"

# 대소문자인지 확인
print(f"HELLO.isupper() : {text1.isupper()}")
print(f"hello.islower() : {text2.islower()}")
print(f"Python.isupper() : {text3.isupper()}")

# 대소문자로 변경
print(f"대문자로 변경 : {text3.upper()}")
print(f"소문자로 변경 : {text3.lower()}")

print("")
print(f"=== 📘 startwith() ===")

word = "Python"

print(word.startswith("Py")) # true
print(word.startswith("py")) # false

# 특정 접두어로 시작하는 단어 필터링
words = ["apple", "banana", "apricot", "cherry"]
a_words = [w for w in words if w.startswith("a")]
print(a_words)

print("")
print(f"=== 📘 split() : 문자열 => 리스트 변환 ===")

sentence = "apple,banana,cherry"
fruits = sentence.split(",")
print(fruits)

sentence2 = "I love Python programming"
words = sentence2.split(" ")
print(words)

print("")
print(f"=== 📘 문자열 + 반복문 ===")
nickname = "WORLDworld"
answer = ""

for letter in nickname:
    if letter == "l":
        answer += "I"
    elif letter == "w":
        answer += "vv"
    else:
        answer += letter

# 길이가 4 미만이면 'o'를 추가
while len(answer) < 4:
    answer += "o"

# 길이가 8을 초과하면 8글자까지만 남김
if len(answer) > 8:
    answer = answer[:8]

print(answer)