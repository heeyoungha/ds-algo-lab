text = """
=========================================
딕셔너리 정렬

딕셔너리를 value 값 기준으로 정렬하는 방법

🔹 sorted() 함수와 lambda 사용
🔹 items() 메서드 활용
"""

print(text)

# 상세 설명과 예시
print("🔸 딕셔너리 정렬 방법")
print("(1) key만 정렬 (value 기준)")
fails = {
    1: 0.2,
    2: 0.5,
    3: 0.5,
    4: 1.0
}

# lambda에서 fails[x] → value 가져와서 정렬 기준으로 사용
# x : 딕셔너리 fails의 key, 즉 스테이지 번호
# 반환: 딕셔너리[key] 리스트
result1 = sorted(fails, key=lambda x: fails[x], reverse=True)
print(f"key만 정렬 => {result1}")

print("(2) (key, value) 튜플로 정렬")
# fails.items()는 (key, value) 튜플을 반환
result2 = sorted(fails.items(), key=lambda x: x[1], reverse=True)
print(f"(key, value) 튜플 정렬 => {result2}")

print("(3) 불필요한 딕셔너리 조회 (비효율적)")
# 각 튜플의 첫 번째 요소(키)를 다시 fails 딕셔너리에 조회
# 불필요하게 딕셔너리를 한번 더 조회
result3 = sorted(fails.items(), key=lambda x: fails[x[0]], reverse=True)
print(f"불필요한 조회 방식 => {result3}")

text = """
=========================================
🧩 연습문제: 실패율 구하기

실패율 : 스테이지에 도달했으나 아직 클리어하지 못한 플레이어의 수 / 스테이지에 도달한 플레이어의 수
stage : 사용자가 멈춰있는 스테이지의 번호

루틴:
1. 각 스테이지별 실패율을 딕셔너리에 저장
2. 실패율 값을 기준으로 내림차순 정렬
3. 정렬된 스테이지 번호 반환
"""
print(text)


print("(1) 딕셔너리 사용")
n = 5
stages = [2, 1, 2, 6, 2, 4, 3, 3]
total = len(stages)

meet_stage_player_cnt = {}
not_clear_stage_player_cnt = {}

# 각 스테이지를 도달한 플레이어 수 계산
for stage in stages:
    for j in range(1, stage):
        meet_stage_player_cnt[j] = meet_stage_player_cnt.get(j, 0) + 1

# 각 스테이지에서 멈춘 플레이어 수 계산
for stage in stages:
    not_clear_stage_player_cnt[stage] = not_clear_stage_player_cnt.get(stage, 0) + 1

# 실패율 계산
answer = {}
for i in range(1, n + 1):
    denominator = meet_stage_player_cnt.get(i, 0)
    if denominator == 0:
        answer[i] = 0
    else:
        answer[i] = not_clear_stage_player_cnt.get(i, 0) / denominator

ordered = sorted(answer.items(), key=lambda x: x[1], reverse=True)
result = [k for k, v in ordered]
print(f"결과 => {result}")

print("(2) 배열 + 누적합")
# 스테이지별 도전자 수
gamer = [0] * (n + 2)
for stage in stages:
    if stage <= n:
        gamer[stage] += 1

# 딕셔너리
fails = {}
total = len(stages)

# 실패율 계산
for i in range(1, n + 1):
    if total == 0:
        fails[i] = 0
    else:
        fails[i] = gamer[i] / total
        total -= gamer[i]

result2 = sorted(fails, key=lambda x: fails[x], reverse=True)
print(f"결과 => {result2}")