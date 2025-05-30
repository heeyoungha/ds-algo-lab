text = """
=========================================
🧩 연습문제: 배열 회전


루틴:
1. arr을 1번 회전할 때 좌표 변경을 함수로 만든다
2. 회전한 횟수만큼 함수를 실행시킨다
"""
print(text)
arr = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 16]
]
# 문제 풀이 코드
def rotate_arr(arr):
    y = len(arr)
    rotate_arr = [[0] * y for _ in range(y)]

    for i in range(y):
        for j in range(len(arr)):
            rotate_arr[j][y-i-1] = arr[i][j]
            # arr[i,j] = arr[y-j,i]
    return rotate_arr

n = 2
for _ in range(n):
    arr = rotate_arr(arr)

print(arr)