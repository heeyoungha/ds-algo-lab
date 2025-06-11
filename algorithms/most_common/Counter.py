## 가장 많이 등장한 key, value
from collections import Counter

labels = ['a', 'b', 'c', 'a', 'b', 'a', 'b']

# 각 요소들은 몇번씩 나왔는지
Counter(labels)
print(Counter(labels))

# 가장 많이 등장한 요소 1개
Counter(labels).most_common(1)[0][0]
print(Counter(labels).most_common(1)[0][0])

# 가장 많이 등장한 값 1개
Counter(labels).most_common(1)[0][1]
print(Counter(labels).most_common(1)[0][1])

# 가장 많이 등장한 모든 요소
max_cnt = max(Counter(labels).values())
most_keys = [k for k, v in Counter(labels).items() if v == max_cnt]
print(most_keys)
