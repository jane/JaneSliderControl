//
//  ExampleViewController.swift
//  JaneSliderControl
//
//  Created by Barlow Tucker on 5/17/16.
//  Copyright © 2016 Jane. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    @IBOutlet weak var topSlider: SliderControl!
    @IBOutlet weak var leftSlider: SliderControl!
    @IBOutlet weak var rightSlider: SliderControl!
    @IBOutlet weak var thinSlider: SliderControl!
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    private func sliderName(slider:SliderControl) -> String {
        switch (slider) {
            case self.topSlider: return "Top Slider"
            case self.leftSlider: return "Middle Left Slider"
            case self.rightSlider: return "Middle Right Slider"
            case self.thinSlider: return "Bottom Slider"
            default: return "Unknown Slider"
        }
    }
    
    @IBAction func resetTapped(sender: AnyObject) {
        self.topSlider.reset()
        self.leftSlider.reset()
        self.rightSlider.reset()
        self.thinSlider.reset()
    }
    @IBAction func sliderChanged(sender: SliderControl) {
        self.sliderLabel.text = self.sliderName(sender)
        self.statusLabel.text = "Changing: Progress - \(sender.progress)"
    }
    @IBAction func sliderFinished(sender: SliderControl) {
        self.sliderLabel.text = self.sliderName(sender)
        self.statusLabel.text = "Finished"
    }
    @IBAction func slideCanceled(sender: SliderControl) {
        self.sliderLabel.text = self.sliderName(sender)
        self.statusLabel.text = "Canceled"
    }
}
