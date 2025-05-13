print("")
print(f"=== 📘 range객체 ===")
"""
- 숫자 시퀀스를 생성하는 내장 자료형
인덱스 접근 가능
iterable : 반복 가능한 객체
immutable : 값을 바꿀 수 없음
메모리 효율 : 숫자를 미리 저장하지 않고 필요할 때 계산
"""
r = range(5)

print( r )
print( type(r) )
print( r[2] )
print( range(2,10,2) )

print( list(range(5)) )
print( list(range(10,2,-2)) )


print("")
print(f"=== 📘 삼항연산자 : 배수이면 1 아니면 0 ===")

# 문제 3
num = 38
n = 2
print(1 if (num % n == 0)  else 0)

# 문제 2

a=2
b=1
flag= False
print(a+b if flag else a-b)

print("")
print(f"=== 📘 공배수 : 두 조건을 모두 만족하면 1 아니면 0 ===")

number = 60
n = 2
m = 3

print( int(bool(number % n == 0) & bool(number % m == 0)) )

print( int(not( (number % n) or (number%m) )) )

print("")
print(f"=== 📘 조건에 따라 요소 다르게 계산하기 ===")

# 1
answer = 0
if (n % 2 == 0):
    for i in range(2,n+1,2):
        answer = answer + i*i
else:
    for i in range(1,n+1,2):
        answer = answer + i
print(answer)

# 2
if (n%2): # 홀수
    answer = sum(range(1,n+1,2))
else:
    answer = sum(i*i for i in range(2,n+1,2))