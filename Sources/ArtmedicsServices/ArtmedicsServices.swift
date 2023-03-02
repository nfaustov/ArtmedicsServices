protocol DependencyKey {
    associatedtype Value

    static var currentValue: Value { get set }
}

struct ArtmedicsServices {
    private static var current = ArtmedicsServices()

    static subscript<K: DependencyKey>(key: K.Type) -> K.Value {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    static subscript<T>(_ keyPath: WritableKeyPath<ArtmedicsServices, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
public struct Dependency<T> {
    private let keyPath: WritableKeyPath<ArtmedicsServices, T>
    public var wrappedValue: T {
        get { ArtmedicsServices[keyPath] }
        set { ArtmedicsServices[keyPath] = newValue }
    }

    init(keyPath: WritableKeyPath<ArtmedicsServices, T>) {
        self.keyPath = keyPath
    }
}
