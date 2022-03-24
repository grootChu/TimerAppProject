//
//  ViewController.swift
//  TimerAppProject
//
//  Created by 추관우 on 2022/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TimerLabel: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.setTitleColor(UIColor.green, for: .normal)
        // Do any additional setup after loading the view.
    }

    @IBAction func resetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "리셋 하시겠습니까?", message: "정말로 리셋 하시겟습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (_) in
            //do nothing
        }))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("시작", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func startstopTapped(_ sender: Any) {
        if(timerCounting)
        {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("시작", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
        }
        else
        { timerCounting = true
        
            startStopButton.setTitle("시작", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.00001, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            
        }
    }
    
    @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        
        return timeString
        
    }
}

