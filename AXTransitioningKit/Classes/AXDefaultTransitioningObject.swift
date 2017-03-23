//
//  AXDefaultTransitioningObject.swift
//  AXTransitioningKit
//
//  Created by devedbox on 2017/3/23.
//  Copyright © 2017年 devedbox. All rights reserved.
//

import UIKit
import AXAnimationChain_Swift

/// Calculate the settling duration of spring animation parameters: mass/stiffness/damping.
///
/// - Parameters:
///   - mass: mass of the spring animation to be calculated.
///   - stiffness: stiffness of the spring animation to be calculated.
///   - damping: damping of the spring animation to be calculated.
///
/// - Returns: duration of the spring to be settling.
internal func settlingDurationForSpring(mass: Double, stiffness: Double, damping: Double) -> Double {
    let beta = damping/(2*mass)
    let omega0 = sqrt(stiffness/mass)
    
    let flag = -log(0.001)/min(beta, omega0)
    let duration = -log(0.0004)/min(beta, omega0)
    
    return (flag + duration) / 2;
}
// Spring settings.
fileprivate let mass = 0.5
fileprivate let stiffness = 100.0
fileprivate let damping = 20.0

class AXDefaultTransitioningObject: NSObject, UIViewControllerAnimatedTransitioning {
    var operation: UINavigationControllerOperation = .none
    var duration: TimeInterval = 0.25
    
    
    // MARK: Inialaizer.
    override init() {
        super.init()
    }
    convenience init(operation: UINavigationControllerOperation) {
        self.init()
        self.operation = operation
    }
    // MARK: UIViewControllerAnimatedTransitioning.
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Fetch container view.
        let containerView = transitionContext.containerView
        // Fetch from view.
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        // Fetch to view.
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        // Add from view to container view.
        containerView.addSubview(fromView)
        // Add to view to container view.
        containerView.addSubview(toView)
        
        
        // Add animations to to view.
        switch operation {
        case .push:
            toView.chainAnimator.basic.property("position.x").fromValue(toView.layer.position.x+toView.bounds.width).toValue(toView.layer.position.x).duration(transitionDuration(using: transitionContext)).easeOut().start {
                transitionContext.completeTransition(true)
            }
        case .pop:
            toView.chainAnimator.basic.property("position.x").fromValue(toView.layer.position.x-toView.bounds.width).toValue(toView.layer.position.x).duration(transitionDuration(using: transitionContext)).easeOut().start {
                transitionContext.completeTransition(true)
            }
        default:// none.
            toView.chainAnimator.basic.property("opacity").fromValue(0.0).toValue(1.0).duration(transitionDuration(using: transitionContext)).start {
                transitionContext.completeTransition(true)
            }
        }
        
    }
    
    
}
