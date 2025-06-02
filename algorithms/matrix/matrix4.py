"""
- 1 : x를 + 1하면서 값을 채우고 x위치가 n과 같거나 다음위치에 갑이 있으면 방향을 전환하다.
- 2 : y의 위치가 n과 같거나 다음 위치에 값이 있으면 방향을 전환한다
- 3 : 다음위치에 값이 있으면 방향을 전환한다
- 4 : 다음 위치에 값이 있으면 방향을 전환한다. 만약 전환해도 값이 있으면 종료한다.
"""
from calendar import firstweekday

n = 3
arr = [[0 for _ in range(n)] for _ in range(n)]

start_y, end_y = 0, n-1
start_x, end_x = 0, n-1

num = 1
while start_y <= end_y and start_x <= end_x:
    # 첫번째 행
    for i in range(start_x, end_x + 1):
        arr[start_y][i] = num
        num += 1
    start_y += 1

    # 마지막 열
    for i in range(start_y, end_y + 1):
        arr[i][end_x] = num
        num += 1
    end_x -= 1

    # 마지막 행
    for i in range(end_x, start_x - 1, -1):
        arr[end_y][i] = num
        num += 1
    end_y -= 1

    # 첫번째 열
    for i in range(end_y, start_y - 1, -1):
        arr[i][start_x] = num
        num += 1
    start_x += 1

print(arr)