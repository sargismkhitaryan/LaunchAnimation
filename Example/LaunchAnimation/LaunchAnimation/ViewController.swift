//
//  ViewController.swift
//  LaunchAnimation
//
//  Created by Sargis on 9/11/18.
//  Copyright © 2018 Sargis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    var mask: CALayer?
    
    @IBOutlet var backView: UIView!
    
    // MARK: - Overriden Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMask()
    }
    
    // MARK: - Private Methods
    
    fileprivate func setupMask() {
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "Logo")!.cgImage
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        
        backView.layer.mask = mask
        
        view.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.4862745098, blue: 0.1411764706, alpha: 1)
        
        animateMask()
    }
    
    fileprivate func animateMask() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1.0
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1
        let initalBounds = NSValue(cgRect: mask!.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        self.mask!.add(keyFrameAnimation, forKey: "bounds")
    }
    
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if (flag) {
            backView.layer.mask = nil
        }
    }
}

