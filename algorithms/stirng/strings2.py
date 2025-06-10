print(f"=== 📘 대소문자 (확인 & 변경) ===")

# (1) 대소문자인지 확인
text1, text2 = "hello", "Python"
print(f"{text1.islower()} | {text2.isupper()}")

# (2) 대소문자로 변경
text1, text2 = "hello", "Python"
print(f"대문자로 변경 : {text1.upper()} | 소문자로 변경 : {text2.lower()}")

print("")
print(f"=== 📘 startswith() ===")

# (1)  startswith()은 대소문자를 구분함
word = "Python"
print(f"(1) {word.startswith("Py")} | {word.startswith("py")}")

# (2) 특정 접두어로 시작하는 단어 필터링
words = ["apple", "banana", "apricot", "cherry"]
print(f"(2) {[w for w in words if w.startswith("a")]}")

print("")
print(f"=== 📘 문자열 => 리스트 (split()) ===")

sentence = "apple,banana,cherry"
print(sentence.split(","))

sentence2 = "I love Python programming"
print(sentence2.split(" "))

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

print("")
print(f"=== 📘 문자열 가운데 뒤집기 ===")
"""문자열의 맨 앞과 뒤만 제외하고 가운데만 뒤집기"""

def reverse_middle(s):
    if len(s) <= 2:
        return s
    first, second = s[:1], s[-1:]
    return first+ s[-2:-len(s):-1] + second

# 예시 1
text1 = "python"
result1 = reverse_middle(text1)
print(f"'{text1}' -> '{result1}'")  # 'python' -> 'pohtyn'

# 예시 2
text2 = "hello"
result2 = reverse_middle(text2)
print(f"'{text2}' -> '{result2}'")  # 'hello' -> 'hlleo'

# 예시 3
text3 = "world"
result3 = reverse_middle(text3)
print(f"'{text3}' -> '{result3}'")  # 'world' -> 'wdlro'

# 예시 4: 짧은 문자열
text4 = "hi"
result4 = reverse_middle(text4)
print(f"'{text4}' -> '{result4}'")  # 'hi' -> 'hi'

# 예시 5: 한 글자
text5 = "a"
result5 = reverse_middle(text5)
print(f"'{text5}' -> '{result5}'")  # 'a' -> 'a'