print(f"=== 📘1. 배열.count() ===")

# data속에서 On과 Off의 개수 세기
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

print(f"on의 갯수 : {on}, off의 갯수 : {off} ")

print("")
print(f"=== 📘2. 배열 인덱스 ===")

# 각 요소가 기준 배열의 몇번째에 속하는지
question = ["call", "respiration", "repeat", "check", "pressure"]
answer = []
basic_order = ["check", "call", "pressure", "respiration", "repeat"]

for q in question:
    for i in range(len(basic_order)):
        if q == basic_order[i]:
            answer.append(i + 1)
print(answer)
