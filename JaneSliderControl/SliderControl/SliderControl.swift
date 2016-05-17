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
    private var shouldSlide: Bool = false
    private let imageView:UIImageView = UIImageView()
    
    //MARK: - IBInspectable Variables
    @IBInspectable public var sliderColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.slider.backgroundColor = self.sliderColor
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
            self.setNeedsLayout()
        }
    }
    @IBInspectable public var sliderImage:UIImage? = nil {
        didSet {
            self.imageView.image = self.sliderImage
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
    private func addVisualConstraints(vertical:String, horizontal:String, view:UIView, toView:UIView = self) {
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
        self.addSubview(self.sliderLabel)
        self.addVisualConstraints("V:|[view]|", horizontal: "H:|[view]|", view: self.sliderLabel)
        
        //Create Slider
        self.slider.translatesAutoresizingMaskIntoConstraints = false
        self.slider.backgroundColor = self.sliderColor
        self.slider.layer.cornerRadius = CGFloat(self.cornerRadius)
        self.slider.layer.masksToBounds = true
        self.addSubview(self.slider)
        self.addVisualConstraints("V:|[view]|", horizontal: "H:|[view]", view: self.slider)
        self.sliderWidthConstraint = NSLayoutConstraint(item: self.slider, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 50)
        self.slider.addConstraint(self.sliderWidthConstraint)
        
        //ImageView for optional slider image
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.slider.addSubview(self.imageView)
        self.imageView.contentMode = .Center
        self.imageView.image = self.sliderImage
        self.addVisualConstraints("V:|[view]|", horizontal: "H:|[view]|", view:self.imageView, toView: self.slider)
        
        //Add pan gesture to slide the slider view
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
        self.addGestureRecognizer(pan)
    }
    
    //MARK: - Public Methods
    func panGesture(recognizer:UIPanGestureRecognizer) {
        let x = recognizer.locationInView(self).x
        
        switch (recognizer.state) {
            case .Began:
                //Only slide if the gestures starts within the slide frame
                 self.shouldSlide = x > (self.sliderWidthConstraint.constant - CGFloat(self.sliderWidth)) && x < self.sliderWidthConstraint.constant
            case .Changed:
                guard self.shouldSlide else { return }
                self.sliderWidthConstraint.constant = x
            case .Ended:fallthrough
            case .Cancelled:
                guard self.shouldSlide else { return }
                self.shouldSlide = false
                
                let sliderControlWidth = self.bounds.size.width
                let progress = x/sliderControlWidth
                let success: Bool
                let finalX: CGFloat
                
                //If we are more than 65% through the swipe and moving the the right direction
                if progress > 0.65 && recognizer.velocityInView(self).x > -1.0 {
                    success = true
                    finalX = sliderControlWidth
                } else {
                    success = false
                    finalX = CGFloat(self.sliderWidth)
                }
                
                self.sliderWidthConstraint.constant = finalX
                self.setNeedsUpdateConstraints()
                
                UIView.animateWithDuration(0.25, animations: { 
                    self.layoutIfNeeded()
                }, completion: { (finished) in
                    
                })
            default: break
        }
    }
}
