import Foundation

extension Collection {
    
    var nilIfEmpty: Self? {
        isEmpty ? nil : self
    }
}

extension Collection where Element: Equatable {
    
    func commonSuffix<T: Collection>(with other: T) -> [Element] where T.Element == Element {
        Swift.zip(reversed(), other.reversed()).prefix { $0.0 == $0.1 }.reversed().map(\.0)
    }
    
    func commonPrefix<T: Collection>(with other: T) -> [Element] where T.Element == Element {
        Swift.zip(self, other).prefix { $0.0 == $0.1 }.map(\.0)
    }
}
