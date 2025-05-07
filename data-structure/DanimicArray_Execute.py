from DanimicArray import DynamicArray, RotatableArray

# DynamicArray 인스턴스 생성
arr = DynamicArray()
print("arr.array: ", arr.array)
print("arr.capacity: ", arr.capacity)
print("arr.length: ", arr.length)

# 1. 원소 추가
arr.append(10)
arr.append(20)
arr.append(30)
print("1.원소 추가:", arr.array)

# # 2. 인덱스로 접근
for i in range(len(arr)):
    print(f"2. 인덱스로 접근: arr[{i}] = {arr[i]}")

# # 3. 원소 삭제
print("3. 인덱스1의 원소 삭제:")
print("원소 삭제 전:", [arr[i] for i in range(len(arr))])
arr.remove(1)
print("삭제 후:", [arr[i] for i in range(len(arr))])

# 4. 더 많은 원소 추가 (용량 확장 테스트)
print("\n4. 용량 확장 테스트:")
for i in range(5):
    arr.append(100 + i)
    print(f"원소 {100 + i} 추가 후 - 길이: {len(arr)}, 용량: {arr.capacity}")

print("\n최종 배열:", [arr[i] for i in range(len(arr))])
