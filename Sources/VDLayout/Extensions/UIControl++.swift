import UIKit

public extension UIControl {

	struct States<Value> {

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

	func setAction(for event: Event = .touchUpInside, _ action: @escaping () -> Void) {
		let target = ActionTarget(action)
		targets[event.rawValue] = target
		addTarget(target, action: #selector(target.objcAction), for: event)
	}

	func addAction(for event: Event = .touchUpInside, _ action: @escaping () -> Void) {
		guard let target = targets[event.rawValue] else {
			setAction(for: event, action)
			return
		}
		let oldAction = target.action
		target.action = {
			oldAction()
			action()
		}
	}

	private var targets: [UInt: ActionTarget] {
		get {
			let result = objc_getAssociatedObject(self, &actionTargetKey) as? [UInt: ActionTarget]
			return result ?? [:]
		}
		set {
			objc_setAssociatedObject(self, &actionTargetKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
}

private final class ActionTarget {

	var action: () -> Void

	init(_ action: @escaping () -> Void) {
		self.action = action
	}

	@objc
	func objcAction() {
		action()
	}
}

extension UIControl.State: Hashable {}

private var actionTargetKey = "actionTargetKey"
private var commandTargetKey = "commandTargetKey"
