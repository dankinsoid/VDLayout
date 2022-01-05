//
//  File.swift
//  
//
//  Created by Данил Войдилов on 05.01.2022.
//

import UIKit

extension UIViewController {
	
	public func present(_ viewController: UIViewController, animated: Bool = true, transition: UIViewTransition, animation: UIAnimationOptions = .default, completion: (() -> Void)? = nil) {
		var delegate: UIViewTransitionPresent? = UIViewTransitionPresent(transition: transition, animation: animation)
		viewController.transitioningDelegate = delegate
		present(viewController, animated: animated) {
			delegate = nil
			completion?()
		}
	}
	
	public func dismiss(animated: Bool = true, transition: UIViewTransition, animation: UIAnimationOptions = .default, completion: (() -> Void)? = nil) {
		var delegate: UIViewTransitionPresent? = UIViewTransitionPresent(transition: transition, animation: animation)
		transitioningDelegate = delegate
		dismiss(animated: animated) {
			delegate = nil
			completion?()
		}
	}
}

open class UIViewTransitionPresent: NSObject, UIViewControllerTransitioningDelegate {
	public var transition: UIViewTransition
	public var animation: UIAnimationOptions
	
	open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		UIViewTransitionAnimatedTransitioning(isPresentation: true, transition: transition, animation: animation)
	}
	
	open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		UIViewTransitionAnimatedTransitioning(isPresentation: false, transition: transition, animation: animation)
	}
	
	public init(transition: UIViewTransition, animation: UIAnimationOptions = .default) {
		self.transition = transition
		self.animation = animation
	}
	
//	optional func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
//
//	optional func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
	
//	open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//		UIPresentationController(presentedViewController: presented, presenting: presenting)
//	}
}

open class UIViewTransitionAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
	public var isPresentation: Bool
	public var transition: UIViewTransition
	public var animation: UIAnimationOptions
	
	public init(isPresentation: Bool, transition: UIViewTransition, animation: UIAnimationOptions = .default) {
		self.isPresentation = isPresentation
		self.transition = transition
		self.animation = animation
	}
	
	public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		animation.duration
	}
	
	public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let key: UITransitionContextViewControllerKey = isPresentation ? .to : .from
		
		guard let controller = transitionContext.viewController(forKey: key) else { return }
		
		if isPresentation {
			controller.view.frame = transitionContext.containerView.bounds
		}
		
		controller.view.addOrRemove(to: transitionContext.containerView, add: isPresentation, transition: transition, animation: animation) {
			transitionContext.completeTransition(true)
		}
	}
}

public enum TransitionType {
	case present, dismiss
}
