from DanimicArray import DynamicArray

class RotableArray(DynamicArray):
    """회전 가능한 동적 배열 클래스"""
    
    def __init__(self):
        super().__init__()
    
    def left_rotate(self, positions):
        """배열을 왼쪽으로 positions만큼 회전"""
        if self.length == 0 or positions == 0:
            return
        
        # positions가 배열 길이보다 클 경우 최적화
        positions = positions % self.length
        
        # 임시 배열에 처음 positions개의 원소 저장
        temp = []
        for i in range(positions):
            temp.append(self.array[i])
        
        # 나머지 원소들을 앞으로 이동
        for i in range(self.length - positions):
            self.array[i] = self.array[i + positions]
        
        # 임시 배열의 원소들을 뒤에 추가
        for i in range(positions):
            self.array[self.length - positions + i] = temp[i]
    
    def right_rotate(self, positions):
        """배열을 오른쪽으로 positions만큼 회전"""
        if self.length == 0 or positions == 0:
            return
        
        # positions가 배열 길이보다 클 경우 최적화
        positions = positions % self.length
        
        # 임시 배열에 마지막 positions개의 원소 저장
        temp = []
        for i in range(self.length - positions, self.length):
            temp.append(self.array[i])
        
        # 원소들을 뒤로 이동
        for i in range(self.length - 1, positions - 1, -1):
            self.array[i] = self.array[i - positions]
        
        # 임시 배열의 원소들을 앞에 추가
        for i in range(positions):
            self.array[i] = temp[i]
    
    def reverse(self):
        """배열을 뒤집기"""
        start = 0
        end = self.length - 1
        
        while start < end:
            # 원소 교환
            self.array[start], self.array[end] = self.array[end], self.array[start]
            start += 1
            end -= 1
    
    def rotate_by_reversal(self, positions):
        """Reversal 알고리즘을 사용한 회전 (효율적인 방법)"""
        if self.length == 0 or positions == 0:
            return
        
        positions = positions % self.length
        
        # 1단계: 처음 positions개 원소 뒤집기
        self._reverse_range(0, positions - 1)
        
        # 2단계: 나머지 원소들 뒤집기
        self._reverse_range(positions, self.length - 1)
        
        # 3단계: 전체 배열 뒤집기
        self._reverse_range(0, self.length - 1)
    
    def _reverse_range(self, start, end):
        """특정 범위의 원소들을 뒤집는 헬퍼 메서드"""
        while start < end:
            self.array[start], self.array[end] = self.array[end], self.array[start]
            start += 1
            end -= 1
    
    def get_array(self):
        """현재 배열을 리스트로 반환"""
        return [self.array[i] for i in range(self.length)]