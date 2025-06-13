print(f"=== 📘 'not in' 연산자: 리스트에 없는지 확인 ===")

# (1) not in: 리스트에 요소가 없는지 확인
fruits = ["apple", "banana", "cherry"]

print(f"(1) 'apple' not in fruits => {'apple' not in fruits}")
print("")

# 중복되지 않는 것만 추가
existing = ["/a", "/a/b", "/c"]
new_items = ["/a", "/a/b", "/d", "/a/c"]
unique = [x for x in new_items if x not in existing]

print(f"(2) unique: {unique} ")
print("")

print(f"=== 📘 리스트 extend() ===")

# extend(): 리스트에 다른 리스트의 모든 요소 추가
list1 = [1, 2, 3]
list2 = [4, 5, 6]
list1.extend(list2)

print(f"list1.extend(list2) => {list1} # 요소들이 개별로 추가됨")
print("")

# append() vs extend() 차이
list3 = [1, 2, 3]
list4 = [4, 5, 6]
list3.append(list4)  # 리스트 자체를 추가
print(f"list3.append(list4) => {list3}  # 리스트가 요소로 추가됨")
print("")

print(f"=== 📘 정렬 시 우선순위 지정 ===")

# (1) 튜플을 key로 사용하여 다중 기준 정렬
directory = ["/a", "/", "/b", "/a/b", "/c"]
sorted_dir = sorted(directory, key=lambda x: (1 if x == "/" else 0, x))
print(f"(1) directory = {directory}")
print("")

# (2) 다른 예시: 특정 값 우선 정렬
numbers = [3, 1, 4, 1, 5, 9, 2, 6]
sorted_nums = sorted(numbers, key=lambda x: (0 if x == 1 else 1, x))
print(f"(2) sorted_nums : {sorted_nums}  # 1이 먼저, 나머지는 오름차순")
print("")

# 문자열 길이 우선, 같으면 알파벳 순
words = ["apple", "pie", "banana", "cat", "dog"]
sorted_words = sorted(words, key=lambda x: (len(x), x))
print(f"sorted_words: {sorted_words}  # 길이 순, 같으면 알파벳 순")
print("")

text = """
=========================================
🧩 연습문제: 명령어 시뮬레이션

리눅스의 mkdir, cp, rm 명령어를 모방하는 알고리즘

사용 기술:
🔹 startswith(): 문자열이 특정 접두어로 시작하는지 확인
🔹 split(): 문자열을 공백으로 분리
🔹 extend(): 리스트에 여러 요소 추가
🔹 리스트 컴프리헨션: 조건에 맞는 요소 필터링
🔹 not in: 리스트 컴프리헨션 안에서 중복 방지

루틴:
1. mkdir: 디렉토리 추가
2. cp: 특정 접두어로 시작하는 디렉토리들을 복사
3. rm: 특정 접두어로 시작하는 디렉토리들 제거
"""
print(text)


def solution(directory, command):
    """
    리눅스 명령어를 시뮬레이션하는 함수

    Args:
        directory: 초기 디렉토리 리스트
        command: 실행할 명령어 리스트

    Returns:
        최종 디렉토리 리스트
    """
    dict_structure = directory.copy()  # 원본 보호

    for cmd in command:
        if cmd.startswith("mkdir"):
            # mkdir 명령어: 디렉토리 추가
            dic = cmd.split(" ")[1]
            dict_structure.append(dic)
            print(f"mkdir : {dict_structure}")

        elif cmd.startswith("cp"):
            # cp 명령어: 특정 접두어로 시작하는 디렉토리들을 복사
            parts = cmd.split(" ")

            dic1 = parts[1]
            dic2 = parts[2]
            rm_dest, _ = parts[1].rsplit("/", 1)
            # cp /a /hello 의 의미:
            # /a를 /hello 아래로 복사하므로 /a/b -> /hello/a/b가 되어야 함
            # dic2 + dic1 + x[len(dic1):] 형태로 복사
            # 예: dic2="/hello", dic1="/a", x="/a/b"
            #     -> "/hello" + "/a" + "/b" = "/hello/a/b"
            print(f"dic1 : {dic1}")
            print(f"dic2 : {dic2}")
            print(f"dest : {rm_dest}")

            # 방법 1: 리스트 컴프리헨션으로 중복 방지 (간결한 방법)
            temp = set(dic1[len(rm_dest):] if dic2 == "/" else dic2 + dic1[len(rm_dest):]
                    for x in dict_structure
                   if x.startswith(dic2))
            dict_structure.extend(temp)
            print(f"cp : {dict_structure}")

            # 방법 2: 덮어쓰기 로직 (주석 처리)
            # temp = [dic2 + dic1 + x[len(dic1):] for x in dict_structure if x.startswith(dic1)]
            # for new_dir in temp:
            #     dict_structure = [x for x in dict_structure if x != new_dir]
            #     dict_structure.append(new_dir)

        elif cmd.startswith("rm"):
            # rm 명령어: 특정 접두어로 시작하는 디렉토리들 제거
            dic = cmd.split(" ")[1]
            dict_structure = [x for x in dict_structure if not x.startswith(dic)]
            print(f"rm : {dict_structure}")

    # 결과 정렬: "/"를 맨 뒤로, 나머지는 알파벳 순
    dict_structure = sorted(dict_structure, key=lambda x: (1 if x == "/" else 0, x))

    return dict_structure


# 테스트 케이스
print("🔸 테스트 케이스")
print("")

test1_directory = ["/"]
test1_command = [
    "mkdir /a",
    "mkdir /a/b",
    "mkdir /a/b/c",
    "cp /a/b /",
    "rm /a"
]
result1 = solution(test1_directory, test1_command)
print(f"입력:")
print(f"  directory = {test1_directory}")
print(f"  command = {test1_command}")
print(f"결과: {result1}")
print("")

test2_directory = ["/"]
test2_command = [
    "mkdir /a",
    "mkdir /a/b",
    "mkdir /a/b/c",
    "cp /a /a/b",
    "rm /a/b/a"
]
result2 = solution(test2_directory, test2_command)
print(f"입력:")
print(f"  directory = {test2_directory}")
print(f"  command = {test2_command}")
print(f"결과: {result2}")
print("")

test3_directory = ["/"]
test3_command = [
    "mkdir /a",
    "mkdir /a/b",
    "mkdir /c",
    "cp /a /",  # /a, /a/b를 /로 복사 (덮어쓰기)
    "cp /a /"   # 같은 명령어 반복 (덮어쓰기로 기존 항목 제거 후 추가)
]
result3 = solution(test3_directory, test3_command)
print(f"입력 (덮어쓰기 테스트):")
print(f"  directory = {test3_directory}")
print(f"  command = {test3_command}")
print(f"결과: {result3}")
