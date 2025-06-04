# (1) 배열 슬라이싱 + set 사용
topping = [1, 2, 3, 1, 4]
cnt = 0
for i in range(2, len(topping)):
    if (len(set(topping[:i])) == len(set(topping[i:]))):
        cnt += 1
print(cnt)

print("")

# (2) 딕셔너리 + set 사용
from collections import Counter

total = Counter(topping)

older = set()
cnt2 = 0

for t in topping:
    older.add(t)
    total[t] -= 1

    if total[t] == 0:
        total.pop(t)

    if len(total) == len(older):
        cnt2 += 1

print(cnt2)