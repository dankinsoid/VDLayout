//
//  File.swift
//  
//
//  Created by Данил Войдилов on 05.01.2022.
//

import UIKit

open class UIViewTransitionPresent: NSObject, UIViewControllerTransitioningDelegate {
	
	open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		nil
	}
	
	open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		nil
	}
	
//	optional func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
//
//	optional func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
	
	open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		UIPresentationController(presentedViewController: presented, presenting: presenting)
	}
}

open class UIViewTransitionAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
	public var transitionType: TransitionType
	public var transition: UIViewTransition
	
	public init(transitionType: TransitionType, transition: UIViewTransition) {
		self.transitionType = transitionType
		self.transition = transition
	}
	
	public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		UIAnimationOptions.defaultDuration
	}
	
	public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		
	}
}

public enum TransitionType {
	case present, dismiss
}
