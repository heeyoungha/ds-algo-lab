print(f"=== 📘 기준 배열을 만들어서 매핑 ===")

# (1) 기준 배열 + 루프 돌면서 확인
question = ["call", "respiration", "repeat", "check", "pressure"]
answer = []
basic_order = ["check", "call", "pressure", "respiration", "repeat"]

for q in question:
    for i in range(len(basic_order)):
        if q == basic_order[i]:
            answer.append(i + 1)
print(f"(1) answer {answer}");
print("")

# (2) 기준 배열을 딕셔너리로 변환해서 lookup을 O(1)로 하기
question = ["call", "respiration", "repeat", "check", "pressure"]
answer = []
basic_order = ["check", "call", "pressure", "respiration", "repeat"]

order_dic = {v: i+1 for i, v in enumerate(basic_order)}
answer = [order_dic[q] for q in question]
print(f"(2) answer {answer}");
print("")

text="""
=== 📘 리스트 컴프리헨션 ===
- 튜플 리스트(candidate_set)에서 2번째 값을 리스트로 출력하기 
"""
print(text)

candidate_set = [
    ("apple", "과일"),
    ("carrot", "채소"),
    ("dog", "동물")
]

labels = [candidate[1] for candidate in candidate_set]
print(labels)

print("")
print(f"=== 📘 리스트에서 값으로 제거 ===")

# 방법 1: 리스트 컴프리헨션 사용 (원본 유지)
original = [1, 2, 3, 4, 5, 3]
removed = [x for x in original if x != 3]
print(f"(1) removed: {removed}")
print("3이 아니면 옮기지 말것 => 3은 모두 제거됨")
print("")

# 방법 2: remove() 메서드 (원본 수정, 첫 번째만 제거)
numbers = [1, 2, 3, 4, 3, 5]
numbers.remove(3)  # 첫 번째 3만 제거
print(f"(2) numbers => {numbers}")
print("원본 배열에서 첫번째 3을 제거")
print("")

# 방법 3: while문 + remove()
numbers = [1, 2, 3, 4, 3, 5]
while 3 in numbers:
    numbers.remove(3)
print(f"(3) numbers => {numbers}")
print("배열에서 모든 3 제거")
print("")

# 방법 4: filter
numbers = [1, 2, 3, 4, 3, 5]
numbers = list(filter(lambda x : x != 3, numbers))
print(f"(4) numbers => {numbers}")
print("배열에서 모든 3 제거")
print("")

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
print("")
