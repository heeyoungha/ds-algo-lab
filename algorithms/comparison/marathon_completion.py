text = """
=========================================
🧩 문제: 완주하지 못한 선수

마라톤에 참여한 선수들의 이름이 담긴 배열 participant와
완주한 선수들의 이름이 담긴 배열 completion이 주어질 때,
완주하지 못한 선수의 이름을 return 하도록 solution 함수를 작성하세요.

제한사항:
- 참가자 중에는 동명이인이 있을 수 있습니다.
- completion의 길이는 participant의 길이보다 1 작습니다.

예시:
participant = ["mislav", "stanko", "mislav", "ana"]
completion = ["stanko", "ana", "mislav"]
답: "mislav" (동명이인이 있으므로 한 명이 완주하지 못함)
=========================================
"""
print(text)

# 예시 데이터
participant = ["mislav", "stanko", "mislav", "ana"]
completion = ["stanko", "ana", "mislav"]

text = """
=========================================
정렬 + zip()을 활용한 두 배열 비교

두 배열을 정렬한 후 zip()으로 비교하여 차이점을 찾는 방법

🔹 zip()
- 동일한 인덱스 위치의 요소끼리 묶어서 (a, b, c, ...) 형태의 튜플을 만든다.
- 전달된 iterable 중 가장 짧은 길이에 맞춰 멈춘다.
- 두 배열을 동시에 순회할 때 유용하다.

🔹 sort()
- 리스트를 오름차순으로 정렬한다 (원본 수정).
- 정렬된 상태에서 비교하면 순서대로 매칭이 가능하다.

🔹 시간복잡도
- sort(): O(n log n)  
    n은 배열의 길이
- zip() 순회: O(n) 
    n은 짧은 배열의 길이
- 전체 시간복잡도: O(n log n)

🔹 공간복잡도: O(1) 
    정렬이 in-place로 수행되는 경우

✅ 장점:
   - 공간복잡도: O(1) - 공간 효율적
   - 동명이인 처리: 정렬로 자동 처리됨

❌ 단점:
   - 시간복잡도: O(n log n) - 해시맵보다 느림
   - 원본 배열이 정렬되어 변경됨 (copy 필요)
=========================================
"""
print(text)

# 정렬 + zip 방법
def solution_sort_zip(participant, completion):
    participant.sort()
    completion.sort()

    for p, c in zip(participant, completion):
        if p != c:
            return p

    return participant[-1]

result = solution_sort_zip(participant.copy(), completion.copy())
print(f"완주하지 못한 선수 (정렬+zip): {result}")

text = """
=========================================
방법 2: remove() 메서드를 활용한 방법

completion의 각 요소를 participant에서 제거하여 남은 요소를 찾는 방법

🔹 remove()
- 리스트에서 첫 번째로 나타나는 특정 값을 제거한다.
- 값이 없으면 ValueError를 발생시킨다.
- 원본 리스트를 수정한다.

🔹 시간복잡도
- completion 순회: O(n)
    n은 completion의 길이
- 각 remove() 연산: O(n)
    리스트에서 요소를 찾기 위해 선형 탐색
    요소를 찾은 후 제거하기 위해 뒤의 요소들을 앞으로 이동
- 전체 시간복잡도: O(n²)

🔹 공간복잡도: O(1)
    원본 리스트만 수정하므로 추가 공간 불필요

✅ 장점:
   - 코드가 매우 간단하고 직관적
   - 공간복잡도: O(1)

❌ 단점:
   - 시간복잡도: O(n²) - 매우 느림
   - 원본 배열이 변경됨 (copy 필요)
   - 동명이인이 있어도 첫 번째만 제거됨 (하지만 문제 조건상 괜찮음)
=========================================
"""
print(text)

# remove() 메서드를 사용한 방법
def solution_remove(participant, completion):
    for c in completion:
        participant.remove(c)
    return participant[0]

result2 = solution_remove(participant.copy(), completion.copy())
print(f"완주하지 못한 선수 (remove): {result2}")

text = """
=========================================
방법 3: 해시맵(딕셔너리)을 활용한 방법

participant의 빈도수를 딕셔너리에 저장하고, completion을 순회하며 빈도수를 감소시켜
value가 1인 요소를 찾는 방법

🔹 딕셔너리 (해시맵)
- 키-값 쌍을 저장하는 자료구조
- 키로 값을 조회하는 시간복잡도: O(1) 평균
- get() 메서드로 기본값과 함께 안전하게 조회 가능

🔹 시간복잡도
- participant 순회: O(n)
    각 요소를 딕셔너리에 추가/증가: O(1) 평균
- completion 순회: O(n)
    각 요소의 카운트 감소: O(1) 평균
- 최종 순회: O(n)
    value가 1인 요소 찾기
- 전체 시간복잡도: O(n)

🔹 공간복잡도: O(n)
    딕셔너리에 최대 n개의 키-값 쌍 저장

✅ 장점:
   - 시간복잡도: O(n) - 가장 빠름
   - 동명이인 처리: 완벽하게 처리
   - 원본 배열 수정 없음

❌ 단점:
   - 공간복잡도: O(n) - 딕셔너리 사용
   - 코드가 다소 길음
=========================================
"""
print(text)

# 해시맵을 사용한 방법
def solution_hash(participant, completion):
    hash_map = {}

    for p in participant:
        hash_map[p] = hash_map.get(p, 0) + 1

    for c in completion:
        hash_map[c] -= 1

    # value가 1인 사람이 미완주자
    for name, count in hash_map.items():
        if count == 1:
            return name

text = """
=========================================
방법 4: Counter를 활용한 방법

collections.Counter를 사용하여 두 배열의 빈도수 차이를 계산하는 방법

🔹 Counter
- collections 모듈의 Counter 클래스
- 리스트의 각 요소의 빈도수를 자동으로 계산
- 딕셔너리의 서브클래스로 내부적으로 딕셔너리 사용
- 두 Counter 객체 간 뺄셈 연산으로 차이 계산 가능

🔹 시간복잡도
- Counter(participant): O(n)
    각 요소의 빈도수 계산
- Counter(completion): O(n)
    각 요소의 빈도수 계산
- 차이 계산: O(n)
    두 Counter의 차이를 계산
- 전체 시간복잡도: O(n)

🔹 공간복잡도: O(n)
    Counter 객체에 최대 n개의 키-값 쌍 저장

✅ 장점:
   - 시간복잡도: O(n) - 해시맵과 동일
   - 코드가 매우 간결하고 읽기 쉬움
   - 동명이인 처리: 완벽하게 처리
   - 원본 배열 수정 없음

❌ 단점:
   - 공간복잡도: O(n) - Counter 객체 사용
   - Counter 객체 생성 오버헤드 (미미함)
=========================================
"""
print(text)

# Counter를 사용한 방법
from collections import Counter

def solution_counter(participant, completion):
    diff = Counter(participant) - Counter(completion)
    return list(diff.keys())[0]


counter_p = Counter(participant)
counter_c = Counter(completion)
print(f"  Counter(participant): {counter_p}")
print(f"  Counter(completion): {counter_c}")

diff = counter_p - counter_c
print(f"  차이: {diff}")
print(f"  결과: {list(diff.keys())[0]}")

text = """
=========================================
📊 방법 비교 요약

💡 결론:
- 실전 추천: 해시맵 또는 Counter 방법 (O(n) 시간)
  * Counter가 코드가 더 간결하므로 선호
- 공간 제약: 정렬 + zip 방법 (O(1) 공간)
- 작은 데이터: remove() 방법도 괜찮음 (코드가 간단하지만 느림)
- 성능 순위: 해시맵/Counter > 정렬+zip > remove()

📊 성능 비교표:
방법        | 시간복잡도 | 공간복잡도 | 코드 간결성 | 추천도
-----------|----------|----------|-----------|-------
해시맵      | O(n)     | O(n)     | ⭐⭐⭐      | ⭐⭐⭐⭐⭐
Counter    | O(n)     | O(n)     | ⭐⭐⭐⭐⭐    | ⭐⭐⭐⭐⭐
정렬+zip   | O(n log n)| O(1)     | ⭐⭐⭐⭐     | ⭐⭐⭐⭐
remove()   | O(n²)    | O(1)     | ⭐⭐⭐⭐⭐    | ⭐⭐
=========================================
"""
print(text)

