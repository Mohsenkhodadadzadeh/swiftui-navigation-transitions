import ObjectiveC

@dynamicMemberLookup
public protocol RuntimePropertyAssociation: RuntimeAssociation {
    associatedtype RuntimeProperties: AnyObject

    var runtimeProperties: RuntimeProperties { get }
}

extension RuntimePropertyAssociation {
    public subscript<P: RuntimeProperty, T>(
        dynamicMember keyPath: KeyPath<RuntimeProperties, P>
    ) -> T? where P.T == T? {
        get {
            let key = unsafeBitCast(Selector(("runtime_\(keyPath.hashValue)")), to: UnsafeRawPointer.self)
            return objc_getAssociatedObject(self, key) as? T
        }
        set {
            var runtimeProperty = runtimeProperties[keyPath: keyPath]
            runtimeProperty.wrappedValue = newValue
            let key = unsafeBitCast(Selector(("runtime_\(keyPath.hashValue)")), to: UnsafeRawPointer.self)
            objc_setAssociatedObject(self, key, newValue, .init(runtimeProperty.policy))
        }
    }

    public subscript<P: RuntimeProperty>(
        dynamicMember keyPath: KeyPath<RuntimeProperties, P>
    ) -> P.T! {
        get {
            let key = unsafeBitCast(Selector(("runtime_\(keyPath.hashValue)")), to: UnsafeRawPointer.self)
            return objc_getAssociatedObject(self, key) as? P.T
        }
        set {
//            var runtimeProperty = runtimeProperties[keyPath: keyPath]
//            runtimeProperty.wrappedValue = newValue
//            let key = unsafeBitCast(Selector(("runtime_\(keyPath.hashValue)")), to: UnsafeRawPointer.self)
//            objc_setAssociatedObject(self, key, newValue, .init(runtimeProperty.policy))
        }
    }
}
