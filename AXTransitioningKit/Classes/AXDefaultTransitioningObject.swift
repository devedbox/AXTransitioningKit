//
//  AXDefaultTransitioningObject.swift
//  AXTransitioningKit
//
//  Created by devedbox on 2017/3/23.
//  Copyright © 2017年 devedbox. All rights reserved.
//

import UIKit

class AXDefaultTransitioningObject: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.0;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    
}
