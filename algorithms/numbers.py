
print(f"=== 📘1. 숫자를 2자리씩 자른 합 ===")

numbers = 632348923
answer = 0

while numbers > 0:
    answer += numbers % 100
    numbers //= 100

print(f"2자리씩 자른 합: {answer}")

print("")
print(f"=== 📘2. 소수점 ===")

import math

decimal_number = 3.14
decimal_number_minus = -3.14

print(f"math.ceil(3.14) : {math.ceil(decimal_number)}")
print(f"math.floor(3.14) : {math.floor(decimal_number)}")
print(f"int(3.14) : {int(decimal_number)}")
print(f"int(-3.14) : {int(decimal_number_minus)}")

print("")
print(f"=== 📘3. 물 부족 (비율 변화) ===")

usage = 500 # 지난달 사용량
change = [10, -10, 10, -10] # 사용량 변화

total_usage = 0
for c in change:
    usage += usage * c/100
    total_usage = usage

print(f"사용량의 변화 이후 총 사용량은? : {total_usage}")
