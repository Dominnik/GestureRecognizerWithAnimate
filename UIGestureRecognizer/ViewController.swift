//
//  ViewController.swift
//  UIGestureRecognizer
//
//  Created by Andrey Kovalenko on 28.11.2019.
//  Copyright © 2019 Andrey Kovalenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var jumpButton: UIButton!
    @IBOutlet weak var rotateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipesObservers()
        tapObserver()
        longPressObserver()
        rotateObserver()
        customView.layer.cornerRadius = customView.frame.size.width / 2
    }

    func swipesObservers() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        
    }
    
    func longPressObserver() {
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        longPress.minimumPressDuration = 2
        self.view.addGestureRecognizer(longPress)
    }
    
    func tapObserver() {
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(tripleTapAction))
        tripleTap.numberOfTapsRequired = 3
        self.view.addGestureRecognizer(tripleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubletapAction))
        doubleTap.require(toFail: tripleTap)
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    
    @objc func handleSwipes(gester: UISwipeGestureRecognizer) {
        
        switch gester.direction {
        case .right:
            swipeLabel.text = "Right Swipe was recognized"
        case .left:
            swipeLabel.text = "Left Swipe was recognized"
        case .up:
            swipeLabel.text = "Up Swipe was recognized"
        case .down:
            swipeLabel.text = "Down Swipe was recognized"
        default:
            break
        }
    }
    
    @objc func tripleTapAction() {
        
        swipeLabel.text = "Triple Tap was recognized"
    }
    
    @objc func doubletapAction() {
        
        swipeLabel.text = "Double Tap was recognized"
        self.rotateView.rotate360Degrees()
        
    }
    
    @objc func longPressAction() {
        
        swipeLabel.text = "Long Press was recognized"
    }
    
    @objc func rotateAction() {
        
        swipeLabel.text = "Rotate was recognized"
    }
    
    func rotateObserver(){
        
            let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateAction))
           self.view.addGestureRecognizer(rotateGesture)

    }
    
    
    @IBAction func doSomeethingOnTap(_ sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 3.0) {
            self.customView.transform = CGAffineTransform(scaleX: 100, y: 100)
            self.customView.alpha = 0
        }
    }
    
    @IBAction func jumpButtonAction(_ sender: UIButton) {
        jumpButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 2.0,
                   delay: 0,
                   usingSpringWithDamping: 0.2,
                   initialSpringVelocity: 6.0,
                   options: .allowUserInteraction,
                   animations: { [weak self] in
                    self?.jumpButton.transform = .identity
        },
                   completion: nil)
    }
}

