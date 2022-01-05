//
//  File.swift
//  
//
//  Created by Данил Войдилов on 05.01.2022.
//

import UIKit

public struct UIAnimationOptions: ExpressibleByArrayLiteral {
	public static var defaultDuration: Double = 0.25
	public static var defaultDamping: CGFloat = 0.825
	
	public var duration: Double
	public var delay: Double
	public var spring: Spring?
	public var options: UIView.AnimationOptions
	
	public init(duration: Double = UIAnimationOptions.defaultDuration, delay: Double = 0, spring: Spring? = nil, options: UIView.AnimationOptions = []) {
		self.duration = duration
		self.delay = delay
		self.spring = spring
		self.options = options
	}
	
	public init(arrayLiteral elements: UIView.AnimationOptions...) {
		self.init(options: UIView.AnimationOptions(elements))
	}
	
	public static var `default`: UIAnimationOptions {
		UIAnimationOptions(options: [.curveEaseInOut])
	}
	
	public static func `default`(_ duration: Double = UIAnimationOptions.defaultDuration, delay: Double = 0, options: UIView.AnimationOptions = [.curveEaseInOut]) -> UIAnimationOptions {
		UIAnimationOptions(duration: duration, delay: delay, options: options)
	}
	
	public static func spring(_ duration: Double = UIAnimationOptions.defaultDuration, delay: Double = 0, damping: CGFloat = UIAnimationOptions.defaultDamping, initialVelocity: CGFloat = 0, options: UIView.AnimationOptions = []) -> UIAnimationOptions {
		UIAnimationOptions(duration: duration, delay: delay, spring: Spring(damping: damping, initialVelocity: initialVelocity), options: options)
	}
	
	public struct Spring {
		public var damping: CGFloat
		public var initialVelocity: CGFloat
		
		public init(damping: CGFloat = UIAnimationOptions.defaultDamping, initialVelocity: CGFloat = 0) {
			self.damping = damping
			self.initialVelocity = initialVelocity
		}
	}
}

extension UIView {
	public static func animate(with options: UIAnimationOptions, _ animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
		if let spring = options.spring {
			animate(withDuration: options.duration, delay: options.delay, usingSpringWithDamping: spring.damping, initialSpringVelocity: spring.initialVelocity, options: options.options, animations: animations, completion: completion)
		} else {
			animate(withDuration: options.duration, delay: options.delay, options: options.options, animations: animations, completion: completion)
		}
	}
}
