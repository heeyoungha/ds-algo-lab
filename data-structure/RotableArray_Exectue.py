from RotableArray import RotableArray

# RotatableArray 인스턴스 생성
rot_arr = RotableArray()

# 원소 추가
for i in range(1, 8):
    rot_arr.append(i)

print("초기 배열:", rot_arr.get_array())

# 1. 왼쪽 회전
print("\n1. 왼쪽으로 2칸 회전:")
rot_arr.left_rotate(2)
print("회전 후:", rot_arr.get_array())

# # 2. 오른쪽 회전
print("\n2. 오른쪽으로 3칸 회전:")
rot_arr.right_rotate(3)
print("회전 후:", rot_arr.get_array())

# # 3. 배열 뒤집기
print("\n3. 배열 뒤집기:")
rot_arr.reverse()
print("뒤집기 후:", rot_arr.get_array())

# # 4. Reversal 알고리즘을 사용한 회전
print("\n4. Reversal 알고리즘으로 왼쪽 2칸 회전:")
rot_arr.rotate_by_reversal(2)
print("회전 후:", rot_arr.get_array())
