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
    
    fileprivate func sliderName(_ slider:SliderControl) -> String {
        switch (slider) {
            case self.topSlider: return "Top Slider"
            case self.leftSlider: return "Middle Left Slider"
            case self.rightSlider: return "Middle Right Slider"
            case self.thinSlider: return "Bottom Slider"
            default: return "Unknown Slider"
        }
    }
    
    @IBAction func resetTapped(_ sender: AnyObject) {
        self.topSlider.reset()
        self.leftSlider.reset()
        self.rightSlider.reset()
        self.thinSlider.reset()
    }
    @IBAction func toggleTapped(_ sender: Any) {
        self.topSlider.setProgress(self.topSlider.progress == 0 ? 1 : 0, animated: true)
        self.leftSlider.setProgress(self.leftSlider.progress == 0 ? 1 : 0, animated: true)
        self.rightSlider.setProgress(self.rightSlider.progress == 0 ? 1 : 0, animated: true)
        self.thinSlider.setProgress(self.thinSlider.progress == 0 ? 1 : 0, animated: true)
    }
    @IBAction func sliderChanged(_ sender: SliderControl) {
        self.sliderLabel.text = self.sliderName(sender)
        self.statusLabel.text = "Changing: Progress: \(sender.progress)"
    }
    @IBAction func sliderFinished(_ sender: SliderControl) {
        self.sliderLabel.text = self.sliderName(sender)
        self.statusLabel.text = "Finished"
    }
    @IBAction func slideCanceled(_ sender: SliderControl) {
        self.sliderLabel.text = self.sliderName(sender)
        self.statusLabel.text = "Canceled"
    }
}
