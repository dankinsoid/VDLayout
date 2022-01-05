//
//  UIKitAnimate.swift
//  Test
//
//  Created by Данил Войдилов on 25.12.2021.
//  Copyright © 2021 ru.pochtabank.Prometheus. All rights reserved.
//

import UIKit
import SwiftUI

public struct UIViewTransition: ExpressibleByArrayLiteral {
	public var transitions: [(Progress, UIView, Any?) -> Void]
	public var keyPathes: [(PartialKeyPath<UIView>, set: (UIView, Any) -> Void)]
	public var initialStates: [Any]
	
	public var isIdentity: Bool {
		transitions.isEmpty
	}
	
	public init<T>(_ keyPath: ReferenceWritableKeyPath<UIView, T>, initialState: T? = nil, transition: @escaping (Progress, UIView, T) -> Void) {
		self.transitions = [{ progress, view, value in
			let value = (value as? T) ?? view[keyPath: keyPath]
			transition(progress, view, value)
		}]
		self.keyPathes = [(keyPath, { if let value = $1 as? T { $0[keyPath: keyPath] = value } })]
		initialStates = initialState.map { [$0] } ?? []
	}
	
	public init(transitions: [(UIViewTransition.Progress, UIView, Any?) -> Void], keyPathes: [(PartialKeyPath<UIView>, set: (UIView, Any) -> Void)], initialStates: [Any]) {
		self.transitions = transitions
		self.keyPathes = keyPathes
		self.initialStates = initialStates
	}
	
	public init(arrayLiteral elements: UIViewTransition...) {
		self = .combined(elements)
	}
	
	public mutating func beforeTransition(view: UIView) {
		initialStates = keyPathes.map { view[keyPath: $0.0] }
	}
	
	public func setInitialState(view: UIView) {
		zip(initialStates, keyPathes).forEach {
			$0.1.set(view, $0.0)
		}
	}
	
	public func callAsFunction(progress: Progress, view: UIView) {
		var initialStates = initialStates
		if initialStates.isEmpty {
			initialStates = keyPathes.map { view[keyPath: $0.0] }
		}
		zip(transitions, initialStates).forEach {
			$0.0(progress, view, $0.1)
		}
	}
	
	public enum Progress {
		case insertion(CGFloat), removal(CGFloat)
		
		public var value: CGFloat {
			get {
				switch self {
				case .insertion(let float): return float
				case .removal(let float): return float
				}
			}
			set {
				switch self {
				case .insertion: self = .insertion(newValue)
				case .removal: self = .removal(newValue)
				}
			}
		}
		
		public var progress: CGFloat {
			get {
				switch self {
				case .insertion(let float): return float
				case .removal(let float): return 1 - float
				}
			}
			set {
				switch self {
				case .insertion: self = .insertion(newValue)
				case .removal: self = .removal(1 - newValue)
				}
			}
		}
		
		public var inverted: Progress {
			switch self {
			case .insertion(let float): return .removal(1 - float)
			case .removal(let float): return .insertion(1 - float)
			}
		}
		
		public var reversed: Progress {
			switch self {
			case .insertion(let float): return .insertion(1 - float)
			case .removal(let float): return .removal(1 - float)
			}
		}
		
		public var direction: Direction {
			get {
				switch self {
				case .insertion: return .insertion
				case .removal: return .removal
				}
			}
			set {
				self = newValue(value)
			}
		}
		
		public var isRemoval: Bool {
			get {
				if case .removal = self {
					return true
				}
				return false
			}
			set {
				direction = newValue ? .removal : .insertion
			}
		}
		
		public var isInsertion: Bool {
			get {
				if case .insertion = self {
					return true
				}
				return false
			}
			set {
				direction = newValue ? .insertion : .removal
			}
		}
		
		public func value<T: VectorArithmetic>(identity: T, transformed: T) -> T {
			var result = (identity - transformed)
			result.scale(by: progress)
			return transformed + result
		}
		
		public static func insertion(_ edge: Edge) -> Progress {
			.insertion(edge.progress)
		}
		
		public static func removal(_ edge: Edge) -> Progress {
			.removal(edge.progress)
		}
		
		public enum Edge {
			case start, end
			
			public var progress: CGFloat {
				switch self {
				case .start: return 0
				case .end: return 1
				}
			}
		}
		
		public enum Direction: String, Hashable, CaseIterable {
			case insertion, removal
			
			public func callAsFunction(_ value: CGFloat) -> Progress {
				switch self {
				case .insertion:	return .insertion(value)
				case .removal: 		return .removal(value)
				}
			}
			
			public func callAsFunction(_ value: Edge) -> Progress {
				switch self {
				case .insertion:	return .insertion(value)
				case .removal: 		return .removal(value)
				}
			}
		}
	}
	
	public static var identity: UIViewTransition {
		UIViewTransition(transitions: [], keyPathes: [], initialStates: [])
	}
	
	public static func combined(_ transitions: [UIViewTransition]) -> UIViewTransition {
		guard !transitions.isEmpty else { return .identity }
		
		var result = UIViewTransition.identity
		
		for transition in transitions.flatMap({ $0.flat }) {
			if let i = result.keyPathes.firstIndex(where: { transition.keyPathes[0].0 == $0.0 }) {
				let current = result.transitions[i]
				result.transitions[i] = {
					current($0, $1, $2)
					transition.transitions[0]($0, $1, $1[keyPath: transition.keyPathes[0].0])
				}
			} else {
				result.transitions += transition.transitions
				result.keyPathes += transition.keyPathes
				result.initialStates += result.initialStates
			}
		}
		if result.initialStates.count != result.transitions.count {
			result.initialStates = []
		}
		return result
	}
	
	public static func combined(_ transitions: UIViewTransition...) -> UIViewTransition {
		.combined(transitions)
	}
	
	public static func asymmetric(insertion: UIViewTransition, removal: UIViewTransition) -> UIViewTransition {
		insertion.filter(\.isInsertion).combined(with: removal.filter({ !$0.isInsertion }))
	}
	
	public static var opacity: UIViewTransition {
		.value(\.alpha, 0)
	}
	
	public static func cornerRadius(_ radius: CGFloat) -> UIViewTransition {
		.value(\.layer.cornerRadius, radius)
	}
	
	public static func scale(_ scale: CGPoint) -> UIViewTransition {
		UIViewTransition(\.transform) { progress, view, transform in
			view.transform = transform.scaledBy(
				x: progress.value(identity: 1, transformed: scale.x),
				y: progress.value(identity: 1, transformed: scale.y)
			)
		}
	}
	
	public static func value<T: VectorArithmetic>(_ keyPath: ReferenceWritableKeyPath<UIView, T>, _ transformed: T) -> UIViewTransition {
		UIViewTransition(keyPath) { progress, view, value in
			view[keyPath: keyPath] = progress.value(identity: value, transformed: transformed)
		}
	}
	
	public static func scale(_ scale: CGFloat) -> UIViewTransition {
		.scale(CGPoint(x: scale, y: scale))
	}
		
	public static func scale(_ scale: CGPoint, anchor: CGPoint) -> UIViewTransition {
		UIViewTransition(\.transform) { progress, view, transform in
			let scaleX = scale.x != 0 ? scale.x : 0.0001
			let scaleY = scale.y != 0 ? scale.y : 0.0001
			let xPadding = 1 / scaleX * (anchor.x - view.layer.anchorPoint.x) * view.bounds.width
			let yPadding = 1 / scaleY * (anchor.y - view.layer.anchorPoint.y) * view.bounds.height
			
			view.transform = transform
				.scaledBy(
					x: progress.value(identity: 1, transformed: scaleX),
					y: progress.value(identity: 1, transformed: scaleY)
				)
				.translatedBy(
					x: progress.value(identity: 0, transformed: xPadding),
					y: progress.value(identity: 0, transformed: yPadding)
				)
		}
	}
	
	public static func scale(_ scale: CGFloat = 0.0001, anchor: CGPoint) -> UIViewTransition {
		.scale(CGPoint(x: scale, y: scale), anchor: anchor)
	}
	
	public static var scale: UIViewTransition { .scale(0.0001) }
	
	public static func anchor(point: CGPoint) -> UIViewTransition {
		UIViewTransition(\.layer.anchorPoint) { progress, view, anchor in
			let anchorPoint = CGPoint(
				x: progress.value(identity: anchor.x, transformed: point.x),
				y: progress.value(identity: anchor.y, transformed: point.y)
			)
			view.layer.anchorPoint = anchorPoint
		}
	}
	
	public static func move(edge: Edge) -> UIViewTransition {
		UIViewTransition(\.transform) { progress, view, transform in
			switch edge {
			case .leading:
				view.transform = transform.translatedBy(x: progress.value(identity: 0, transformed: -view.frame.width), y: 0)
			case .trailing:
				view.transform = transform.translatedBy(x: progress.value(identity: 0, transformed: view.frame.width), y: 0)
			case .top:
				view.transform = transform.translatedBy(x: 0, y: progress.value(identity: 0, transformed: -view.frame.height))
			case .bottom:
				view.transform = transform.translatedBy(x: 0, y: progress.value(identity: 0, transformed: view.frame.height))
			}
		}
	}
	
	public static func slide(insertion: Edge, removal: Edge) -> UIViewTransition {
		.asymmetric(insertion: .move(edge: insertion), removal: .move(edge: removal))
	}
	
	public static var slide: UIViewTransition {
		.slide(insertion: .leading, removal: .trailing)
	}
	
	public func combined(with transition: UIViewTransition) -> UIViewTransition {
		.combined(self, transition)
	}
	
	private var flat: [UIViewTransition] {
		if initialStates.isEmpty {
			return zip(transitions, keyPathes).map {
				UIViewTransition(transitions: [$0.0], keyPathes: [$0.1], initialStates: [])
			}
		} else {
			return zip(zip(transitions, keyPathes), initialStates).map {
				UIViewTransition(transitions: [$0.0.0], keyPathes: [$0.0.1], initialStates: [$0.1])
			}
		}
	}
	
	public func filter(_ type: @escaping (Progress) -> Bool) -> UIViewTransition {
		UIViewTransition(
			transitions: transitions.map { transition in
				{
					guard type($0) else { return }
					transition($0, $1, $2)
				}
			},
			keyPathes: keyPathes,
			initialStates: initialStates
		)
	}
	
	public var inverted: UIViewTransition {
		UIViewTransition(
			transitions: transitions.map { transition in
				{
					transition($0.inverted, $1, $2)
				}
			},
			keyPathes: keyPathes,
			initialStates: initialStates
		)
	}
	
	public var reversed: UIViewTransition {
		UIViewTransition(
			transitions: transitions.map { transition in
				{
					transition($0.reversed, $1, $2)
				}
			},
			keyPathes: keyPathes,
			initialStates: initialStates
		)
	}
}

extension UIView {
	func setAnchorPoint(_ point: CGPoint) {
		var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
		var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
		
		newPoint = newPoint.applying(transform)
		oldPoint = oldPoint.applying(transform)
		
		var position = layer.position
		
		position.x -= oldPoint.x
		position.x += newPoint.x
		
		position.y -= oldPoint.y
		position.y += newPoint.y
		
		layer.position = position
		layer.anchorPoint = point
	}
	
	fileprivate subscript(keyPathes keyPathes: [PartialKeyPath<UIView>]) -> [Any] {
		keyPathes.map {
			self[keyPath: $0]
		}
	}
}

extension UIView {
	
	public func set(hidden: Bool, transition: UIViewTransition, animation: UIAnimationOptions = .default, completion: (() -> Void)? = nil) {
		set(hidden: hidden, set: { $0.isHidden = $1 }, transition: transition, animation: animation, completion: completion)
	}
	
	public func removeFromSuperview(transition: UIViewTransition, animation: UIAnimationOptions = .default, completion: (() -> Void)? = nil) {
		set(hidden: true, set: { if $1 { $0.removeFromSuperview() } }, transition: transition, animation: animation, completion: completion)
	}
	
	public func add(subview: UIView, transition: UIViewTransition, animation: UIAnimationOptions = .default, completion: (() -> Void)? = nil) {
		subview.set(hidden: false, set: { if $1 { $0.removeFromSuperview() } else { self.add(subview: $0) } }, transition: transition, animation: animation, completion: completion)
	}
	
	private func set(hidden: Bool, set: @escaping (UIView, Bool) -> Void, transition: UIViewTransition, animation: UIAnimationOptions = .default, completion: (() -> Void)? = nil) {
		guard !transition.isIdentity else {
			set(self, hidden)
			completion?()
			return
		}
		var transition = transition
		transition.beforeTransition(view: self)
		let direction: UIViewTransition.Progress.Direction = hidden ? .removal : .insertion
		transition(progress: direction(.start), view: self)
		if !hidden {
			set(self, false)
		}
		UIView.animate(with: animation) {
			transition(progress: direction(.end), view: self)
		} completion: { _ in
			if hidden {
				set(self, true)
			}
			transition.setInitialState(view: self)
			completion?()
		}
	}
}
