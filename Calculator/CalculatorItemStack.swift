protocol CalculateItem {
    // 필요한 프로토콜 요구사항을 정의하세요.
}

struct CalculatorItemStack<dataType: CalculateItem> {

    private(set) var mainStack: [dataType] = []
    private(set) var tempStack: [dataType] = []

    mutating func push(element: dataType) {
        mainStack.append(element)
    }
    
    mutating func pop() -> dataType? {
        if tempStack.isEmpty {
            while !mainStack.isEmpty {
                tempStack.append(mainStack.removeLast())
            }
        }
        return tempStack.popLast()
    }
    
    mutating func clearStack() {
        mainStack.removeAll()
        tempStack.removeAll()
    }
    
    func isEmpty() -> Bool {
        return mainStack.isEmpty && tempStack.isEmpty
    }
    
    func peek() -> dataType? {
        if !tempStack.isEmpty {
            return tempStack.last
        } else {
            return mainStack.last
        }
    }
}
