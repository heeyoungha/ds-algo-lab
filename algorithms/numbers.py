
question = 1
print(f"=== 📘 {question}. 숫자를 2자리씩 자른 합 ===")

numbers = 632348923
answer = 0

while numbers > 0:
    answer += numbers % 100
    numbers //= 100

print(f"2자리씩 자른 합: {answer}")

print("")
question += 1
print(f"=== 📘 {question}. 소수점 ===")

import math

decimal_number = 3.14
decimal_number_minus = -3.14

print(f"math.ceil(3.14) : {math.ceil(decimal_number)}")
print(f"math.floor(3.14) : {math.floor(decimal_number)}")
print(f"int(3.14) : {int(decimal_number)}")
print(f"int(-3.14) : {int(decimal_number_minus)}")

print("")
question += 1
print(f"=== 📘 {question}. 물 부족 (비율 변화) ===")

usage = 500 # 지난달 사용량
change = [10, -10, 10, -10] # 사용량 변화

total_usage = 0
for c in change:
    usage += usage * c/100
    total_usage = usage

print(f"사용량의 변화 이후 총 사용량은? : {total_usage}")

print("")
print(f"=== 📘 sum() ===")

"""
sum() 함수는 반복 가능한(iterable)객체를 받은 후,
모든 요소를 순서대로 합계를 구한다.
"""

# 1
print(sum(range(5))) # range 객체
print(sum([1,2,3,4,5])) # 리스트
print(sum((1,2,3,4,5))) # 튜플
print(sum(i+i for i in range(5))) # gernerator 표현식

# 2
a = 1
d = 2
included = [True, False, True, False, False, False, True]
seq = [a + d*i for i in range(len(included))]
print(sum(item for i, item in enumerate(seq) if included[i]))
# sum은 iterable 객체를 받을 수 있으므로 리스트로 감싸지 않아도 됨
#   ex) sum([item for i, item in enumerate(seq) if included[i]])

print(sum(a + i * d for i, f in enumerate(included) if f))

# 3

num_list = [1,2,3,4,5]

print(sum(num_list))
print(i for i in num_list)


print("")
print(f"=== 📘 int() ===")
"""
정수로 변환할 때 사용하는 기본 함수
- 실수 -> 정수 : 1.2 -> 1
- 문자열 -> 정수 : "42" -> 42
  - 문자열이 숫자 형식이 아니면 오류 발생(ValueError)
- 불리언 -> 정수 : true -> 1
- 
"""

num=4
n=2
print(int(num % n == 0))

mode = 0
ret =''
code= 144325157421
for idx, i in enumerate(range(code)):
    if mode:
        if i != "1" and idx %2 != 0:
            ret += i
        elif i == "1":
            mode = 0
    else:
        if i != "1" and idx %2 == 0:
            ret += i
        elif i == "1":
            mode = 1

print (ret if ret else "EMPTY")

print("")
print(f"=== 📘 제곱 ===")

a = 1
for i in num_list:
    a = a * i

print(1 if a < sum(num_list) * sum(num_list) else 0)

print(int(a < sum(num_list) ** 2))
