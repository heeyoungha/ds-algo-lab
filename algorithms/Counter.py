from collections import Counter

text = """
=========================================
🧩 Counter(iterable)

반복 가능한(iterable) 객체에서 
"각 항목이 몇 번 등장했는지" 세어주는 역할

🔹 Counter(iterable) => Counter 객체
🔹 Counter객체.most_common(n) => 가장 많이 등장한 n개 반환
"""
print(text)

# (1) Counter 기본 사용
labels = ['A', 'B', 'A', 'C', 'A', 'B', 'B']
label_counts = Counter(labels)
print(f"(1) Counter(labels) => {label_counts}")
print("")

# (2) most_common()
predicted_label = label_counts.most_common(1)
print(f"(2) label_counts.most_common(1) => {predicted_label}")
print("")

# (3) 리스트객체.count('A')
print(f"(3) labels.count('A') => {labels.count('A')}")
text = """
=========================================
🧩 리스트.count() 메서드

리스트에서 특정 값의 개수를 세는 방법

🔹 [list].count(값) => 해당 값의 개수 반환
"""
print(text)

# (1) 2차원 배열에서 특정 값 개수 세기
data = [
    ["On", "On", "On"],
    ["Off", "On", "-"],
    ["Off", "-", "-"]
]

on = 0
off = 0

for station in data:
    on += station.count("On")
    off += station.count("Off")

print(f"(1) on의 개수: {on}, off의 개수: {off}")

text = """
=========================================
🧩 연습문제: 가장 많이 등장한 단어 찾기
"""
print(text)

"""
문제: 문자열 배열 words에서 가장 많이 등장한 단어를 찾기

입력:
words = ["banana", "apple", "banana", "kiwi", "apple", "banana"]

출력:
"banana" (3번 등장)

루틴:
1. Counter를 사용해 각 단어의 등장 횟수 세기
2. most_common(1)로 가장 많이 등장한 단어 찾기
3. 결과 반환
"""

words = ["banana", "apple", "banana", "kiwi", "apple", "banana"]

# 방법 1: Counter
word_counts = Counter(words)
most_common_word = word_counts.most_common(1)[0][0]
print(f"(1) Counter(words).most_common(1)[0][0] => '{most_common_word}'")
print(f"등장 횟수 - Counter(words)[most_common_word] => {Counter(words)[most_common_word]}")

print("")

# 방법 2: max(딕셔너리, key=딕셔너리.get)
words = ["banana", "apple", "banana", "kiwi", "apple", "banana"]

dict = {} # key별 카운트하는 딕셔너리
for word in words:
    dict[word] = dict.get(word, 0) + 1

print(f"(2) max(word_dict, key=word_dict.get) => '{max(dict, key=dict.get)}'")
print(f"등장 횟수 - word_dict[most_common_word] => {dict[max(dict, key=dict.get)]}")

print("")

# 방법 3: 딕셔너리 + sorted + lambda
sorted_dict = sorted(dict.items(), key = lambda v : v[1], reverse = True)

print(f"(3) sorted + lambda 사용: '{sorted_dict[0][0]}'")
print(f"등장 횟수 - sorted_dict[0][1] => {sorted_dict[0][1]}")