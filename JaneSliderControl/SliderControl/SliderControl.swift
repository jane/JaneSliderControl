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
    private let slider:CALayer = CALayer()
    private let sliderLabel:UILabel = UILabel()
    
    //MARK: - IBInspectable Variables
    @IBInspectable public var sliderColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable public var cornerRadius:Float = 0 {
        didSet {
            self.layer.cornerRadius = CGFloat(self.cornerRadius)
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
    private func setupSlider() {
        //Apply the custom slider styling
        self.layer.cornerRadius = CGFloat(self.cornerRadius)
        self.layer.masksToBounds = true
        
        //Add the slider label and set the constraints that will keep it centered
        self.addSubview(self.sliderLabel)
        
    }
    
    //MARK: - Public Methods
    
}
