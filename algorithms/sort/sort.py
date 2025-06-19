text = """
=========================================
정렬 함수 기본

🔹 sorted(iterable) => 새로운 정렬된 리스트 반환
🔹 [list].sort() => 원본 리스트를 정렬 (None 반환)
=========================================
"""
print(text)

text = """
=========================================
집합(Set) 정렬

{5, 4, 3, 2} => [2, 3, 4, 5]

🔹 sorted(set) => 리스트로 반환
🔹 set(list) => 리스트를 다시 세트로 반환
=========================================
"""
print(text)

number_set = {5, 4, 3, 2}
print(f"sorted({number_set}) => {sorted(number_set)}")
print(f"type: {type(sorted(number_set))}")
print("")
print(f"set(sorted(number_set)) => {set(sorted(number_set))}")
print(f"type: {type(set(sorted(number_set)))}")

text = """
=========================================
딕셔너리(Dict) 정렬

{"Alice": 85, "Bob": 92, "Charlie": 78} => 정렬

🔹 sorted(dict) => 키만 정렬된 리스트
🔹 sorted(dict.items()) => (키, 값) 튜플 리스트
🔹 sorted(dict.items(), key=lambda x: x[1]) => 값 기준 정렬
=========================================
"""
print(text)

scores = {"Alice": 85, "Bob": 92, "Charlie": 78}
print("(1) 키만 정렬")
print(f"sorted(scores) => {sorted(scores)}")
print("")
print("(2) (키, 값) 튜플 리스트로 정렬 (내림차순)")
print(f"sorted(scores.items(), reverse=True) => {sorted(scores.items(), reverse=True)}")
print("")
print("(3) 값 기준 정렬 (내림차순)")
print(f"sorted(scores.items(), key=lambda x: x[1], reverse=True) => {sorted(scores.items(), key=lambda x: x[1], reverse=True)}")
