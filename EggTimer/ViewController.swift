//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


fileprivate let eggTimes        : [String: Int] = ["Soft"   : 5,
                                                   "Medium" : 7,
                                                   "Hard"   : 12]
fileprivate let timerInterval   : Double        = 1.0

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel  : UILabel!
    @IBOutlet weak var progressBar : UIProgressView!
    
    var seconds  : Float   = 0
    var time     : Float   = 0
    
    var timer    : Timer?
    var player   : AVPlayer?
    
    
    @IBAction func eggPress(_ sender: UIButton) {
        guard let eggType : String = sender.titleLabel?.text else { return }
        
        guard let minutes : Int = eggTimes[eggType] else { return }
        
        if (timer == nil) {
            seconds              = 0
            time                 = Float(minutes) * 1.0//60.0
            progressBar.progress = 0.0
            timer = Timer.scheduledTimer(timeInterval   : timerInterval,
                                         target         : self,
                                         selector       : #selector(updateTimer),
                                         userInfo       : nil,
                                         repeats        : true)
        }
    }
    
    @objc func updateTimer() {
        if (seconds != time) {
            seconds += 1
            progressBar.progress = seconds / time
            print(seconds)
        } else {
            titleLabel.text = "DONE!!!"
            playSound("alarm_sound", format: "mp3")
            timer?.invalidate()
            timer = nil
            progressBar.progress = 0.0
            
        }
    }
    
    private func playSound(_ soundName: String, format: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: format) else { return }
    
        player = AVPlayer(url: url)
        
        player?.play()
    }

}
