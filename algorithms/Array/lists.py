print(f"=== 📘 배열 인덱스 ===")

# 각 요소가 기준 배열의 몇번째에 속하는지
question = ["call", "respiration", "repeat", "check", "pressure"]
answer = []
basic_order = ["check", "call", "pressure", "respiration", "repeat"]

for q in question:
    for i in range(len(basic_order)):
        if q == basic_order[i]:
            answer.append(i + 1)
print(answer)

print("")
print(f"=== 📘 리스트 컴프리헨션 ===")

candidate_set = [
    ("apple", "과일"),
    ("carrot", "채소"),
    ("dog", "동물")
]
labels = [candidate[1] for candidate in candidate_set]
print(labels)



