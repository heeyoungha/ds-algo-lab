text = """
=========================================
숫자와 관련된 다양한 연산 방법을 학습

🔹 나머지 연산자 (%)
🔹 몫 연산자 (//)
🔹 math 모듈 (ceil, floor)
🔹 int() 함수
"""
print(text)

# 사용 도구
print("🔸 숫자를 2자리씩 자른 합")
print("(1) 숫자를 100으로 나눈 나머지를 구하여 2자리씩 추출")
print("(2) 몫 연산자(//)를 사용하여 다음 자리로 이동")
print("(3) 추출한 값들을 누적하여 합계 계산")

numbers = 632348923
answer = 0

while numbers > 0:
    answer += numbers % 100
    numbers //= 100

print(f"2자리씩 자른 합: {answer}")

print("")
print("🔸 소수점 처리")
print("(1) math.ceil(): 올림 - 소수점이 있으면 다음 정수로 올림")
print("(2) math.floor(): 내림 - 소수점을 버림")
print("(3) int(): 소수점 이하를 버림 (양수는 floor와 동일, 음수는 다름)")

import math

decimal_number = 3.14
decimal_number_minus = -3.14

print(f"math.ceil(3.14) : {math.ceil(decimal_number)}")
print(f"math.floor(3.14) : {math.floor(decimal_number)}")
print(f"int(3.14) : {int(decimal_number)}")
print(f"int(-3.14) : {int(decimal_number_minus)}")

print("")
print("🔸 비율 변화 계산")
print("(1) 초기값에 변화율을 적용하여 새로운 값 계산")
print("(2) 변화율은 백분율로 표현 (10 = 10%)")
print("(3) 반복문을 통해 여러 번의 변화 적용")

usage = 500  # 지난달 사용량
change = [10, -10, 10, -10]  # 사용량 변화

total_usage = 0
for c in change:
    usage += usage * c/100
    total_usage = usage

print(f"사용량의 변화 이후 총 사용량은? : {total_usage}")

text = """
=========================================
🧩 연습문제: sum() 함수 활용

sum() 함수는 반복 가능한(iterable) 객체를 받아 모든 요소의 합계를 구함

루틴:
1. range, 리스트, 튜플 등 다양한 iterable 객체 사용
2. generator 표현식과 함께 사용
3. 조건부 합계 계산

"""
print(text)

# 문제 풀이 코드
print("(1) 기본 사용법")
print(sum(range(5)))  # range 객체
print(sum([1, 2, 3, 4, 5]))  # 리스트
print(sum((1, 2, 3, 4, 5)))  # 튜플
print(sum(i+i for i in range(5)))  # generator 표현식

print("")
print("(2) 조건부 합계 계산")
a = 1
d = 2
included = [True, False, True, False, False, False, True]
seq = [a + d*i for i in range(len(included))]
print(sum(item for i, item in enumerate(seq) if included[i]))
# sum은 iterable 객체를 받을 수 있으므로 리스트로 감싸지 않아도 됨
#   ex) sum([item for i, item in enumerate(seq) if included[i]])

print(sum(a + i * d for i, f in enumerate(included) if f))

print("")
print("(3) 리스트 합계")
num_list = [1, 2, 3, 4, 5]
print(sum(num_list))

text = """
=========================================
🧩 연습문제: int() 함수 활용

문제: int() 함수는 다양한 타입을 정수로 변환합니다.

루틴:
1. 실수 -> 정수 변환
2. 문자열 -> 정수 변환
3. 불리언 -> 정수 변환 (True=1, False=0)

"""
print(text)

# 문제 풀이 코드
print("🔸 int() 함수 설명")
print("정수로 변환할 때 사용하는 기본 함수")
print("- 실수 -> 정수 : 1.2 -> 1")
print("- 문자열 -> 정수 : \"42\" -> 42")
print("  - 문자열이 숫자 형식이 아니면 오류 발생(ValueError)")
print("- 불리언 -> 정수 : True -> 1, False -> 0")

print("")
print("(1) 불리언을 정수로 변환")
num = 4
n = 2
print(int(num % n == 0))

print("")
print("(2) 문자열 처리 예제")
mode = 0
ret = ''
code = "144325157421"
for idx, i in enumerate(code):
    if mode:
        if i != "1" and idx % 2 != 0:
            ret += i
        elif i == "1":
            mode = 0
    else:
        if i != "1" and idx % 2 == 0:
            ret += i
        elif i == "1":
            mode = 1

print(ret if ret else "EMPTY")

text = """
=========================================
🧩 연습문제: 제곱 연산

제곱 연산을 활용한 비교 연산을 수행

1. 리스트 요소들의 곱 계산
2. 리스트 합계의 제곱 계산
3. 두 값을 비교하여 결과 반환

"""
print(text)

# 문제 풀이 코드
a = 1
for i in num_list:
    a = a * i

print(f"리스트 합의 제곱: {sum(num_list) ** 2}")
print(1 if a < sum(num_list) * sum(num_list) else 0)
print(int(a < sum(num_list) ** 2))
