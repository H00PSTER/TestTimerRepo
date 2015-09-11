//
//  ViewController.swift
//  TestTimer
//
//  Created by Chris Yerina on 9/1/15.
//  Copyright (c) 2015 Chris Yerina. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    let timeInterval: NSTimeInterval = 0.5
    var currentTime: Double = 0.0
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.datePicker.countDownDuration = 60.0
        self.pauseButton.hidden = true
        self.stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timeToString(time: Double) -> String {
        let hours = Int(time) / 3600
        
        var minutes = Int(time) / 60
        
        if hours != 0 {
            minutes = Int(time) / 60 - (60)
        }
        
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        
        if self.startButton.selected == false {
            self.currentTime = self.datePicker.countDownDuration
            self.timeDisplay.text = timeToString(currentTime)
            self.datePicker.hidden = true
            
            timerDidStart()
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
            
            self.startButton.selected = true
        }
        else {
            self.startButton.hidden = true
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        }
        
    }
    
    @IBAction func stopTimer(sender: AnyObject) {
        timerStoppedOrEnd()
    }
    
    
    @IBAction func pauseTimer(sender: AnyObject) {
        self.timer.invalidate()
        self.timeDisplay.text = timeToString(self.currentTime)
        self.startButton.hidden = false
    }
    
    func updateTimer() {
        
        switch currentTime{
        
        case 0.0:
            vibrate()
            timerStoppedOrEnd()
        
        default:
            self.currentTime -= 1.0
        }
        
        self.timeDisplay.text = timeToString(self.currentTime)
    }

    //MARK: Helper Functions
    
    func timerStoppedOrEnd() {
        self.timer.invalidate()
        self.timeDisplay.text = "Set Timer"
        self.startButton.hidden = false
        self.startButton.selected = false
        self.pauseButton.hidden = true
        self.stopButton.hidden = true
        self.datePicker.hidden = false
    }
    
    func timerDidStart() {
        self.stopButton.hidden = false
        self.pauseButton.hidden = false
        self.startButton.hidden = true
    }
    
    func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}

