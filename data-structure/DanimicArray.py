class DynamicArray:
    """배열 생성"""
    def make_array(self, capacity):
        return [None] * capacity

    """초기화"""
    def __init__(self):
        self.capacity = 1 # 메타데이터: 몇개의 원소를 담을 수 있는지
        self.length = 0 # 메타데이터: 몇개의 원소가 들어가 있는지
        self.array = self.make_array(self.capacity) # 실제 원소를 담는 리스트

    """인덱스로 접근"""
    def __getitem__(self, index):
        if 0 <= index < self.length: # 인덱스 제약조건 : 0보다 크고 자신의 길이보다 작아야 함
            return self.array[index]
        raise IndexError("Index out of range")

    """배열 크기 재조정"""
    def _resize(self, new_capacity):
        new_array = self.make_array(new_capacity) # 새로 옮길 리스트 생성
        for i in range(self.length): # 새로 옮길 리스트에 복사
            new_array[i] = self.array[i]
        self.array = new_array # 기존 array변수에 새로운 리스트 할당
        self.capacity = new_capacity # 커지는 만큼 용량 재설정. 원소의 갯수는 변하지 않으므로 length는 그대로.

    """배열 끝에 원소 추가"""
    def append(self, item):
        if self.length == self.capacity: # 만약 추가할 자리가 없으면 배열 크기 재조정
            self._resize(self.capacity * 2)
        self.array[self.length] = item # 배열의 끝에 원소 추가
        self.length += 1 # 배열의 갯수 업데이트

    """인덱스 위치의 원소 삭제"""
    def remove(self, index):
        if 0 <= index < self.length:
            for i in range(index, self.length - 1):
                self.array[i] = self.array[i + 1]
            self.array[self.length - 1] = None
            self.length -= 1
        else:
            raise IndexError("Index out of range")

    """길이 함수"""
    def __len__(self):
        return self.length