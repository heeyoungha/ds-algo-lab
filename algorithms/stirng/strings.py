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
print(f"=== 📘 문자열 자르기 [:] ===")
# (1) 뒤에서 3번째부터 마지막까지 자르기
code = "asdk_apl"
last_four_words = code[-4:]
print(f"(1) 마지막 4글자 : {last_four_words}")

# (2) 뒤에서부터 3번째까지 역순으로 자르기
code = "asdk_apl"
last_four_words = code[-1:-4:-1]
print(f"(2) 마지막 4글자 : {last_four_words}")

# ⚠️ last_four_words = code[-1:-4]는 안됨
print(f"⚠️ 파이썬 슬라이싱은 기본적으로 왼->오른쪽임. reverse를 지정해야함")

print("")
print(f"=== 📘 문자열 섞기 (''+str) ===")

str1 = "12345"
str2 = 	"abcde"
answer = ''
for i in range(len(str1)):
        answer += str1[i]
        answer += str2[i]
print(answer)

print("")
print(f"=== 📘 문자열 곱하기 (str*2) ===")

my_string = "str"
k = 2
answer = my_string * k
print(answer)

print("")
print(f"=== 📘 큰 수로 합치기 (f-string) ===")

a = 9
b = 12

""" 
str(int)로 int > str 변환
max() 비교
"""
a, b = str(a), str(b)
print(max(int(a + b), int(b + a)))