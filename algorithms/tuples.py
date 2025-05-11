print(f"=== 📘1. tuple unpacking1 ===")
pairs = [(1,2), (3,4)]

for a, b in pairs:
    print(a, b)
#출력:
#1 2
#3 4

print(f"=== 📘1. tuple unpacking2 ===")
sorted_genres = [('pop', 3100), ('classic', 1450)]

for a, _ in sorted_genres:
    print(a)

# 출력:
# pop
# classic


print(f"=== 📘2. 딕셔너리 items 객체 ===")
play_dic = {
    "classic": 1000,
    "pop": 5000,
    "rock": 10
}

print("---- key : value 형태 ----")
# dict_items 객체 (이터러블 형태로 반환)
print(play_dic.items())
# 리스트로 변환
print(list(play_dic.items()))

play_dic2 = {
    "classic": [1000,200],
    "pop": [5000,800,90],
    "rock": [10,300,6]
}
print("---- key : [list] 형태 ----")
# dict_items 객체 (이터러블 형태로 반환)
print(play_dic2.items())
# []로 감싸기
print([play_dic2.items()])

print("---- 반복문으로 이터러블 객체의 key, value 출력 ----")
# 반복문으로 이터러블 객체의 key, value 출력
for k, v in play_dic.items():
    print(f"{k}: {v}")