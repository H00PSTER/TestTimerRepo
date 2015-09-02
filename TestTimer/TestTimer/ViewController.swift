//
//  ViewController.swift
//  TestTimer
//
//  Created by Chris Yerina on 9/1/15.
//  Copyright (c) 2015 Chris Yerina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.datePicker.countDownDuration = 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setTime(sender: AnyObject) {
        
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        timeDisplay.text = toString(self.datePicker.countDownDuration)
    }

}

