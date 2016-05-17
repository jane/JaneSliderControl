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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
