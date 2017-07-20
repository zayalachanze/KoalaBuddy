//
//  StartWalkViewController.swift
//  Koala Buddy
//
//  Created by Zaya Gooding on 7/18/17.
//  Copyright © 2017 Zaya Gooding. All rights reserved.
//

import UIKit

class StartWalkViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var walkTimePickerView: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startWalkButton: UIButton!

    var times = ["5 Minutes", "10 Minutes", "15 Minutes", "20 Minutes", "30 Minutes", "45 Minutes", "1 Hour", "2 Hours"]

    var walkTimer = Timer()
    var walkCounter: Int?

    var minuteNumber = 0
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.isHidden = true
        startWalkButton.isHidden = true
        
        walkTimePickerView.delegate = self
        walkTimePickerView.dataSource = self
        
        startWalkButton.layer.cornerRadius = 10
        
        //Timer
    }

    
    // Picker View Setup
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return times[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeLabel.text = times[row]
    }
    
    //Select Time
    @IBAction func timeSelected(_ sender: Any) {

        self.walkTimePickerView.removeFromSuperview()
        self.nextButton.removeFromSuperview()
        timerLabel.isHidden = false
        startWalkButton.isHidden = false
        guard let h = timeLabel.text else {
            return
        }
        
        switch h {
        case "5 Minutes":
            minuteNumber = 5
        case "10 Minutes":
            minuteNumber = 10
        case "15 Minutes":
            minuteNumber = 15
        case "20 Minutes":
            minuteNumber = 20
        case "30 Minutes":
            minuteNumber = 30
        case "45 Minutes":
            minuteNumber = 45
        case "1 Hour":
            minuteNumber = 60
        case "2 Hours":
            minuteNumber = 120
        default:
            break
        }
        
        walkCounter = (minuteNumber) * 60
        
        guard let x = walkCounter else {
            return
        }
        timerLabel.text = String(describing: x) + " seconds left"
    }
    
   
    @IBAction func startWalk(_ sender: UIButton) {
        if !isTimerRunning {
            runCountdown()
        }
    }
    
    func runCountdown() {
        walkTimer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateCountdown)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    func updateCountdown() {
    guard var y = walkCounter else {
        return
    }
        if y > 0 {
            y -= 1
            self.walkCounter! -= 1
            timerLabel.text = String(y) + " seconds left"
        } else {
            timerLabel.text = "Walk Done!"
            walkTimer.invalidate()
            isTimerRunning = false
        }
        
    }
}


