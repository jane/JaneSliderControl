//
//  SliderControl.swift
//  JaneSliderControl
//
//  Created by Barlow Tucker on 5/17/16.
//  Copyright © 2016 Jane. All rights reserved.
//

import UIKit

@IBDesignable public class SliderControl: UIControl {
    //MARK: - Private Variables
    private let slider:UIView = UIView()
    private let sliderLabel:UILabel = UILabel()
    private var sliderWidthConstraint:NSLayoutConstraint!
    private var sliderImageWidthConstraint:NSLayoutConstraint!
    private var shouldSlide: Bool = false
    private let imageView:UIImageView = UIImageView()
    
    //MARK: - Public Variables
    private(set) var progress:Float = 0.0
    
    //MARK: - IBInspectable Variables
    @IBInspectable public var sliderColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.slider.backgroundColor = self.sliderColor
            self.setNeedsLayout()
        }
    }
    @IBInspectable public var textColor:UIColor = UIColor.blackColor() {
        didSet {
            self.sliderLabel.textColor = self.textColor
            self.setNeedsLayout()
        }
    }
    @IBInspectable public var cornerRadius:Float = 0 {
        didSet {
            self.layer.cornerRadius = CGFloat(self.cornerRadius)
            self.slider.layer.cornerRadius = CGFloat(self.cornerRadius)
            self.setNeedsLayout()
        }
    }
    @IBInspectable public var sliderText:String = "" {
        didSet {
            self.sliderLabel.text = sliderText
            self.setNeedsLayout()
        }
    }
    @IBInspectable public var sliderWidth:Float = 50.0 {
        didSet {
            self.sliderWidthConstraint.constant = CGFloat(self.sliderWidth)
            self.sliderImageWidthConstraint.constant = CGFloat(self.sliderWidth)
            self.setNeedsLayout()
        }
    }
    @IBInspectable public var sliderImage:UIImage? = nil {
        didSet {
            self.imageView.image = self.sliderImage
            self.setNeedsLayout()
        }
    }
    @IBInspectable public var sliderImageContentMode:UIViewContentMode = .ScaleAspectFit {
        didSet {
            self.imageView.contentMode = self.sliderImageContentMode
            self.setNeedsLayout()
        }
    }
    @IBInspectable public var sliderFont:UIFont = UIFont.systemFontOfSize(14) {
        didSet {
            self.sliderLabel.font = self.sliderFont
            self.setNeedsLayout()
        }
    }
    
    //MARK: - UIControl
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSlider()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSlider()
    }
    
    //MARK: - Private Methods
    private func addVisualConstraints(vertical:String, horizontal:String, view:UIView, toView:UIView) {
        let veritcalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(vertical, options: [], metrics: nil, views: ["view":view])
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(horizontal, options: [], metrics: nil, views: ["view":view])
        self.addConstraints(veritcalConstraints)
        self.addConstraints(horizontalConstraints)
    }
    
    private func setupSlider() {
        //Apply the custom slider styling
        self.layer.cornerRadius = CGFloat(self.cornerRadius)
        self.layer.masksToBounds = true
        
        //Add the slider label and set the constraints that will keep it centered
        self.sliderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sliderLabel.textAlignment = .Center
        self.sliderLabel.textColor = self.textColor
        self.sliderLabel.font = self.sliderFont
        self.addSubview(self.sliderLabel)
        self.addVisualConstraints("V:|[view]|", horizontal: "H:|[view]|", view: self.sliderLabel, toView: self)
        
        //Create Slider
        self.slider.translatesAutoresizingMaskIntoConstraints = false
        self.slider.backgroundColor = self.sliderColor
        self.slider.layer.cornerRadius = CGFloat(self.cornerRadius)
        self.slider.layer.masksToBounds = true
        self.addSubview(self.slider)
        self.addVisualConstraints("V:|[view]|", horizontal: "H:|[view]", view: self.slider, toView: self)
        self.sliderWidthConstraint = NSLayoutConstraint(item: self.slider, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(self.sliderWidth))
        self.slider.addConstraint(self.sliderWidthConstraint)
        
        //ImageView for optional slider image
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.slider.addSubview(self.imageView)
        self.imageView.contentMode = self.sliderImageContentMode
        self.imageView.image = self.sliderImage
        self.addVisualConstraints("V:|[view]|", horizontal: "H:[view]|", view:self.imageView, toView: self.slider)
        self.sliderImageWidthConstraint = NSLayoutConstraint(item: self.imageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(self.sliderWidth))
        self.imageView.addConstraint(self.sliderImageWidthConstraint)
        
        //Add pan gesture to slide the slider view
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
        self.addGestureRecognizer(pan)
    }
    
    //MARK: - Public Methods
    public func reset() {
        self.progress = 0.0
        self.sliderWidthConstraint.constant = CGFloat(self.sliderWidth)
        self.setNeedsUpdateConstraints()
        self.layoutIfNeeded()
    }
    
    func panGesture(recognizer:UIPanGestureRecognizer) {
        let x = recognizer.locationInView(self).x
        let padding: CGFloat = 20.0
        
        switch (recognizer.state) {
            case .Began:
                //Only slide if the gestures starts within the slide frame
                self.shouldSlide = x > (self.sliderWidthConstraint.constant - CGFloat(self.sliderWidth)) && x < self.sliderWidthConstraint.constant + padding
                self.sendActionsForControlEvents(.EditingDidBegin)
            case .Changed:
                guard self.shouldSlide && x > CGFloat(self.sliderWidth) else { return }
                self.sliderWidthConstraint.constant = x
                self.progress = Float(x/self.bounds.size.width)
                self.sendActionsForControlEvents(.ValueChanged)
            case .Ended:fallthrough
            case .Cancelled:
                guard self.shouldSlide else { return }
                self.shouldSlide = false
                
                self.progress = Float(x/self.bounds.size.width)
                let success: Bool
                let finalX: CGFloat
                
                //If we are more than 65% through the swipe and moving the the right direction
                if self.progress > 0.65 && recognizer.velocityInView(self).x > -1.0 {
                    success = true
                    finalX = self.bounds.size.width
                } else {
                    success = false
                    finalX = CGFloat(self.sliderWidth)
                    self.progress = 0.0
                }
                
                self.sliderWidthConstraint.constant = finalX
                self.setNeedsUpdateConstraints()
                
                UIView.animateWithDuration(0.25, animations: { 
                    self.layoutIfNeeded()
                }, completion: { (finished) in
                    if success {
                        if #available(iOS 9.0, *) {
                            self.sendActionsForControlEvents(.PrimaryActionTriggered)
                        }
                        
                        self.sendActionsForControlEvents(.EditingDidEnd)
                    } else {
                        self.sendActionsForControlEvents(.TouchCancel)
                    }
                })
            default: break
        }
    }
}
