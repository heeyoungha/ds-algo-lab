text = """
=========================================
2개의 행렬 arr1과 arr2를 입력받아, 행렬 덧셈의 결과를 반환하는 함수

arr1 : [[1,2],[2,3]]	
arr2 : [[3,4],[5,6]]
return : [[4,6],[7,9]]
=========================================
"""
print(text)

A = [[1, 2], [2, 3], [4, 5], [6, 7]]
B = [[4, 5], [6, 7], [8, 9], [10, 11]]

# (1) 리스트 컴프리헨션 + zip()
for a, b in zip(A, B):
    print(f"{a}, {b}")

print(list(list(c + d for c, d in zip(a, b)) for a, b in zip(A, B)))

# (2) 새로운 배열에 담기
answer = []
for i in range(len(A)):
    row = []
    for j in range(len(A[0])):
        row.append(A[i][j] + B[i][j])
    answer.append(row)
print(answer)

# (3) A배열과 B배열을 합치기
for i in range(len(A)):
    for j in range(len(A[0])):
        A[i][j] = A[i][j] + B[i][j]
print(A)
