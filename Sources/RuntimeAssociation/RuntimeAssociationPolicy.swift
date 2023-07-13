import ObjectiveC

/// Policies related to associative references.
public enum RuntimeAssociationPolicy {
	public enum Atomicity {
		case atomic
		case nonatomic
	}

	/// Specifies an unsafe unretained reference to the associated object.
	case assign
	/// Specifies that the associated object is copied.
	case copy(Atomicity)
	/// Specifies a strong reference to the associated object.
	case retain(Atomicity)

	var rawValue: objc_AssociationPolicy {
		switch self {
		case .assign:
			return .OBJC_ASSOCIATION_ASSIGN
		case .copy(.atomic):
			return .OBJC_ASSOCIATION_COPY
		case .copy(.nonatomic):
			return .OBJC_ASSOCIATION_COPY_NONATOMIC
		case .retain(.atomic):
			return .OBJC_ASSOCIATION_RETAIN
		case .retain(.nonatomic):
			return .OBJC_ASSOCIATION_RETAIN_NONATOMIC
		}
	}
}
