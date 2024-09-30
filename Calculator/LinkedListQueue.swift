class Node<T> {
    var value: T
    var next: Node?

    init(value: T) {
        self.value = value
    }
}

struct LinkedListQueue<dataType: CalculateItem> {
    private var head: Node<dataType>?
    private var tail: Node<dataType>?
    
    mutating func enqueue(element: dataType) {
        let newNode = Node(value: element)
        if tail != nil {
            tail!.next = newNode
        }
        tail = newNode
        if head == nil {
            head = tail
        }
    }
    
    mutating func dequeue() -> dataType? {
        guard let headNode = head else {
            return nil
        }
        head = headNode.next
        if head == nil {
            tail = nil // If the queue is now empty, reset the tail
        }
        return headNode.value
    }
    
    mutating func clearQueue() {
        head = nil
        tail = nil
    }
    
    func isEmpty() -> Bool {
        return head == nil
    }
    
    func peek() -> dataType? {
        return head?.value
    }
}
