import UIKit

extension UIControl {
    
    public struct States<Value> {
        
        private let get: (State) -> Value?
        private let set: (Value?, State) -> Void
        
        public subscript(_ key: State) -> Value? {
            get { get(key) }
            nonmutating set { set(newValue, key) }
        }
        
        public init(get: @escaping (State) -> Value?, set: @escaping (Value?, State) -> Void) {
            self.get = get
            self.set = set
        }
    }
}

extension UIControl.State: Hashable {}
