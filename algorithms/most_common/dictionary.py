## 가장 많이 등장한 key, value

labels = ['a', 'b', 'c', 'a', 'b', 'a', 'b']

dict = {}
for label in labels:
    dict[label] = dict.get(label, 0) + 1

# 가장 많이 등장한 요소 1개 (1)
max(dict, key=dict.get)
print(max(dict, key=dict.get))

# 가장 많이 등장한 요소 1개 (2)
sorted_dict = sorted(dict.items(), key = lambda v : v[1], reverse = True)
print(sorted_dict[0][0])

#가장 많이 등장한 값 1개
dict[max(dict, key=dict.get)]
print(dict[max(dict, key=dict.get)])

# 가장 많이 등장한 값 1개 (2)
sorted_dict = sorted(dict.items(), key = lambda v : v[1], reverse = True)
print(sorted_dict[0][1])

# 가장 많이 등장한 모든 요소(1)
max_cnt = dict[max(dict, key=dict.get)]
most_keys = [k for k, v in dict.items() if v == max_cnt]
print(most_keys)
