from collections import Counter

# 배열 비교
participant = ["mislav", "stanko", "mislav", "ana"]
completion = ["stanko", "ana", "mislav"]

# 첫번째 배열에만 있는 요소 찾기
diff = Counter(participant) - Counter(completion)
counter_key = diff.keys()
print(list(counter_key)[0])

text = """
=========================================
Counter 객체의 keys() 메서드

Counter 객체에서 모든 키(요소)를 가져오는 방법

🔹 keys() 메서드
- Counter 객체의 모든 키를 반환
- dict_keys 객체를 반환 (리스트처럼 사용 가능)
- list()로 변환하여 리스트로 사용 가능
- 값이 0보다 큰 키만 반환됨 (0인 키는 제외)

🔹 기본 사용법
counter = Counter(["a", "b", "a", "c"])
keys = counter.keys()        # dict_keys 객체
keys_list = list(counter.keys())  # 리스트로 변환

🔹 시간복잡도: O(n)
    n은 Counter의 키 개수

🔹 활용 예시
- Counter의 모든 요소(키) 목록 가져오기
- 뺄셈 결과에서 남은 요소 찾기
- 특정 조건을 만족하는 키 필터링
=========================================
"""
print(text)

# (1) keys() 기본 사용
counter = Counter(["apple", "banana", "apple", "orange", "banana"])
print(f"Counter: {counter}")
print(f"counter.keys(): {counter.keys()}")
print(f"list(counter.keys()): {list(counter.keys())}")
print()

# (2) keys()와 뺄셈 연산 함께 사용
participant = ["mislav", "stanko", "mislav", "ana"]
completion = ["stanko", "ana", "mislav"]

counter_p = Counter(participant)
counter_c = Counter(completion)
diff = counter_p - counter_c

print(f"Counter(participant): {counter_p}")
print(f"Counter(completion): {counter_c}")
print(f"차이: {diff}")
print(f"diff.keys(): {diff.keys()}")
print(f"list(diff.keys()): {list(diff.keys())}")
print(f"완주하지 못한 선수: {list(diff.keys())[0]}")
print()

# (3) keys()로 모든 요소 순회
print("[keys()로 모든 요소 순회]")
for key in counter.keys():
    print(f"  {key}: {counter[key]}개")
print()

text = """
=========================================
🧩 연습문제 4: Counter의 keys() 활용 - 완주하지 못한 선수

Counter 뺄셈 결과에서 keys()를 사용하여 완주하지 못한 선수를 찾으세요.

입력:
participant = ["mislav", "stanko", "mislav", "ana"]
completion = ["stanko", "ana", "mislav"]

출력:
"mislav"

루틴:
1. Counter(participant)와 Counter(completion)을 만든다
2. 두 Counter의 차이를 계산한다
3. 차이의 keys()를 사용하여 키 목록을 가져온다
4. list()로 변환하여 첫 번째 요소를 반환한다
"""
print(text)

def solution_with_keys(participant, completion):
    diff = Counter(participant) - Counter(completion)
    return list(diff.keys())[0]

participant_ex = ["mislav", "stanko", "mislav", "ana"]
completion_ex = ["stanko", "ana", "mislav"]

result = solution_with_keys(participant_ex, completion_ex)
print(f"participant: {participant_ex}")
print(f"completion: {completion_ex}")
print(f"Counter(participant): {Counter(participant_ex)}")
print(f"Counter(completion): {Counter(completion_ex)}")
print(f"차이: {Counter(participant_ex) - Counter(completion_ex)}")
print(f"diff.keys(): {(Counter(participant_ex) - Counter(completion_ex)).keys()}")
print(f"list(diff.keys()): {list((Counter(participant_ex) - Counter(completion_ex)).keys())}")
print(f"결과: {result}")

text = """
=========================================
🧩 연습문제 5: keys()로 중복 제거된 요소 목록 만들기

리스트에서 중복을 제거하고 유일한 요소만 가져오세요.

입력:
items = ["apple", "banana", "apple", "orange", "banana", "kiwi"]

출력:
["apple", "banana", "orange", "kiwi"]

루틴:
1. Counter(items)로 각 요소의 개수를 센다
2. keys()를 사용하여 모든 키를 가져온다
3. list()로 변환하여 리스트로 만든다
"""
print(text)

items = ["apple", "banana", "apple", "orange", "banana", "kiwi"]
counter_items = Counter(items)

print(f"원본 리스트: {items}")
print(f"Counter: {counter_items}")
print(f"counter.keys(): {counter_items.keys()}")
unique_items = list(counter_items.keys())
print(f"중복 제거된 요소: {unique_items}")

# 비교: set() 사용
print(f"\n비교 - set() 사용: {list(set(items))}")
print("차이점: Counter.keys()는 입력 순서를 유지, set()은 순서가 보장되지 않음")

text = """
=========================================
🧩 연습문제 6: keys()로 특정 조건 만족하는 요소 찾기

Counter에서 값이 2 이상인 요소만 찾으세요.

입력:
words = ["apple", "banana", "apple", "orange", "banana", "apple"]

출력:
["apple", "banana"] (2번 이상 등장한 단어)

루틴:
1. Counter(words)로 각 단어의 개수를 센다
2. keys()로 모든 키를 가져온다
3. 각 키의 값이 2 이상인지 확인하여 필터링한다
"""
print(text)

words = ["apple", "banana", "apple", "orange", "banana", "apple"]
counter_words = Counter(words)

print(f"원본: {words}")
print(f"Counter: {counter_words}")
print(f"counter.keys(): {list(counter_words.keys())}")

# 값이 2 이상인 요소 찾기
frequent_words = [key for key in counter_words.keys() if counter_words[key] >= 2]
print(f"2번 이상 등장한 단어: {frequent_words}")

print("\n[상세 분석]")
for key in counter_words.keys():
    count = counter_words[key]
    print(f"  {key}: {count}번 등장 {'✓ (2 이상)' if count >= 2 else '✗ (2 미만)'}")

text = """
=========================================
🧩 연습문제 7: keys()와 items() 비교

Counter의 keys()와 items()의 차이를 이해하세요.

입력:
data = ["a", "b", "a", "c", "b", "a"]

출력:
keys(): 키만 반환
items(): (키, 값) 튜플 반환
"""
print(text)

data = ["a", "b", "a", "c", "b", "a"]
counter_data = Counter(data)

print(f"원본: {data}")
print(f"Counter: {counter_data}")
print()

print("keys() 사용:")
print(f"  counter.keys(): {counter_data.keys()}")
print(f"  list(counter.keys()): {list(counter_data.keys())}")
print()

print("items() 사용:")
print(f"  counter.items(): {counter_data.items()}")
print(f"  list(counter.items()): {list(counter_data.items())}")
print()

print("keys()로 값 접근:")
for key in counter_data.keys():
    print(f"  {key}: {counter_data[key]}개")
print()

print("items()로 값 접근:")
for key, value in counter_data.items():
    print(f"  {key}: {value}개")

text = """
=========================================
Counter의 keys() 메서드 핵심 정리

🔹 기본 문법
keys = counter.keys()           # dict_keys 객체
keys_list = list(counter.keys()) # 리스트로 변환

🔹 반환 타입
- dict_keys 객체 (리스트처럼 사용 가능)
- list()로 변환하여 리스트로 사용 가능

🔹 특징
- 값이 0보다 큰 키만 반환 (0인 키는 제외)
- 입력 순서를 유지 (Python 3.7+)
- 중복 제거된 키 목록 제공

🔹 활용 예시
- 완주하지 못한 선수 찾기: list(diff.keys())[0]
- 중복 제거: list(Counter(items).keys())
- 조건 필터링: [key for key in counter.keys() if 조건]
- 모든 요소 순회: for key in counter.keys()

🔹 keys() vs items()
- keys(): 키만 반환
- items(): (키, 값) 튜플 반환
- 값이 필요하면 items() 사용, 키만 필요하면 keys() 사용

🔹 주의사항
- keys()는 dict_keys 객체를 반환하므로 인덱싱 불가
- 인덱싱이 필요하면 list()로 변환 필요
- Counter는 딕셔너리의 서브클래스이므로 딕셔너리 메서드 사용 가능
=========================================
"""
print(text)