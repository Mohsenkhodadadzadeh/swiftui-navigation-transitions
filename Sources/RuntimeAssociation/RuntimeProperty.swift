import ObjectiveC

public protocol RuntimeProperty {
    associatedtype T

    var policy: RuntimeAssociationPolicy { get }
    var wrappedValue: T { get set }
}

@propertyWrapper
public struct assign<T>: RuntimeProperty {
    public var policy: RuntimeAssociationPolicy { .assign }
    public var wrappedValue: T
    public var projectedValue: Self { self }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

// TODO: parameterize `policy` when the following is implemented:
// https://forums.swift.org/t/allow-property-wrappers-with-multiple-arguments-to-defer-initialization-when-wrappedvalue-is-not-specified/38319
@propertyWrapper
public struct copyAtomic<T>: RuntimeProperty {
    public var policy: RuntimeAssociationPolicy { .copy(.atomic) }
    public var wrappedValue: T
    public var projectedValue: Self { self }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

// TODO: parameterize `policy` when the following is implemented:
// https://forums.swift.org/t/allow-property-wrappers-with-multiple-arguments-to-defer-initialization-when-wrappedvalue-is-not-specified/38319
@propertyWrapper
public struct copyNonatomic<T>: RuntimeProperty {
    public var policy: RuntimeAssociationPolicy { .copy(.nonatomic) }
    public var wrappedValue: T
    public var projectedValue: Self { self }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

// TODO: parameterize `policy` when the following is implemented:
// https://forums.swift.org/t/allow-property-wrappers-with-multiple-arguments-to-defer-initialization-when-wrappedvalue-is-not-specified/38319
@propertyWrapper
public struct retainAtomic<T>: RuntimeProperty {
    public var policy: RuntimeAssociationPolicy { .retain(.atomic) }
    public var wrappedValue: T
    public var projectedValue: Self { self }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

// TODO: parameterize `policy` when the following is implemented:
// https://forums.swift.org/t/allow-property-wrappers-with-multiple-arguments-to-defer-initialization-when-wrappedvalue-is-not-specified/38319
@propertyWrapper
public struct retainNonatomic<T>: RuntimeProperty {
    public var policy: RuntimeAssociationPolicy { .retain(.nonatomic) }
    public var wrappedValue: T
    public var projectedValue: Self { self }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}
