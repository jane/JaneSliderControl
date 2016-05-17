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
    private func addVisualConstraints(vertical:String, horizontal:String, view:UIView) {
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
        self.addVisualConstraints("V:|[view]|", horizontal: "H:|[view(50)]", view: self.slider)
        
    }
    
    //MARK: - Public Methods
    
}
