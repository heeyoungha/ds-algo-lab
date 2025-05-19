text = """
=========================================
 숫자 <=> 문자열 

12345 <=> "12345"  

🔹 str(int)
🔹 int(str)
=========================================
"""
print(text)

print(f"str(1234) => {type(str(1234))}")
print(f"int('12345') => {type(int('12345'))} ")

text = """
=========================================
문자열 => 리스트  

"abcde" => ['e', 'a', 'b', 'c', 'd']

🔹 [list].sort() => None
🔹 sorted(iterable) => 리스트
=========================================
"""
print(text)

print("🔸 'abcde'.sort() => ❌ sort()는 [list].sort() 형태만 가능")
print("🔸 sorted('abcde') => ✅ sorted(iterable) ")
print("")
print("(1) sorted()로 정렬하면 원본은 그대로")

text = "abcde"
up_text = sorted(text, reverse=False)

print(f"up_text = sorted(text, reverse=False) => {sorted(text, reverse=False)}")
print(f"text => {text}")
print("")
print("(2) sort()함수는 void")
print(f"up_text.sort(reverse=True) => {up_text.sort(reverse=True)}")
print("")
print("(3) sort()함수는 원본이 정렬")
print(f"up_text => {up_text}")
print("")
print("(4) 리스트 => 문자열, 정렬")
print(f"''.join(sorted(up_text, reverse=False)) => {''.join(sorted(up_text, reverse=False))}")

text = """
=========================================
리스트 => 문자열 

['e', 'a', 'b', 'c', 'd'] => "abcde"  

🔹 ''.join([리스트])
=========================================
"""
print(text)

print("(1) join()은 문자열로 이루어진 iterable을 합칠 때 사용")
print(f"''.join(['1','2','3','4','5'] => {''.join(['1','2','3','4','5'])}")
print(f"''.join([str(x) for x in [1,2,3,4,5]]) => {''.join([str(x) for x in [1,2,3,4,5]])}")
print(f"''.join(map(str, [1,2,3,4,5])) => {''.join(map(str, [1,2,3,4,5]))}")


text = """
=========================================
🧩 연습문제: MathChallenge
=========================================
"""
print(text)

"""
문제: 함수에 전달되는 num 매개변수는 
최소 두 자리 이상의 서로 다른 숫자인 4자리 숫자.

루틴:
1. 숫자를 내림차순과 오름차순으로 정렬
2. 큰 숫자에서 작은 숫자를 뺌 (4자리 맞추기 위해 0 추가)
3. 결과가 6174에 도달할 때까지 반복
4. 6174에 도달하기까지 반복 횟수 반환

예시:
num = 3524
(1) 5432 - 2345 = 3087
(2) 8730 - 0378 = 8352
(3) 8532 - 2358 = 6174
정답: 3
"""

count = 0
num = 12

num = str(num).zfill(4)

num_str = str(num)
while len(num_str) < 4:
    num_str += "0"

while True:
    down = int(''.join(sorted(num_str, reverse=True)))
    up = int(''.join(sorted(num_str, reverse=False)))

    num = down - up
    count += 1

    if num == 6174:
        break
    num_str = str(num)

print(count)