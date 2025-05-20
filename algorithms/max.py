text = """
=========================================
max() 기본 사용법

🔹 max(값1, 값2, ...) => 최대값 반환
🔹 max(iterable) => iterable의 최대값 반환
🔹 max(iterable, key=함수) => 함수 반환값 기준으로 비교
=========================================
"""
print(text)

# (1) 숫자 비교
print(f"(1) max(1, 5, 3) => {max(1, 5, 3)}")
print("")
# (2) 리스트에서 최대값
print(f"(2) max([1, 5, 3]) => {max([1, 5, 3])}")
print("")
# (3) 문자열 비교 (사전순)
print(f"(3) max('cat') => {max('cat')}")

print("")
print("------------------ 비교기준 설정 ---------------------")
print("")
# (4) key 매개변수 사용
words = ["apple", "banana", "kiwi"]
print(f"words = {words}")
print(f"(4) max(words, key=len) => {max(words, key=len)}")

print("")
# (5) 딕셔너리에서 max() 사용 - 키 기준 비교 (사전순)
word_dict = {"apple": 7, "banana": 2, "orange": 1}
print(f"(5) max(word_dict) => {max(word_dict)}")

print("")
# (6) 딕셔너리에서 max() 사용 값 기준으로 최대 키 찾기
print(f"(6) max(iterable, key=word_dict.get) => "
      f"{max(word_dict, key=word_dict.get)}")

print("key=iterable.get은 '키를 넣으면 값을 반환하는 함수'를 전달")
print("max는 각 키의 iterable.get(키) 값을 비교해 최대값을 선택")

