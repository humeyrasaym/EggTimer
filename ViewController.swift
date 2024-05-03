//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft" : 3, "Medium": 4, "Hard": 7]
    var totalSecond = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }
    
    @IBAction func hardnessPressed(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        timer.invalidate()
        
        totalSecond = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        titleLabel.text = hardness
        secondsPassed = 0
        
        
        //print(hardness, eggTimes[hardness]!)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {

        if secondsPassed <= totalSecond {
            progressBar.progress = Float(secondsPassed) / Float(totalSecond)
            secondsPassed += 1
           
        } else {
            timer.invalidate()
            titleLabel.text = "Done"
            playSound()
        }
                    
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
                return }
            let url = URL(fileURLWithPath: path)

            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
    }
    
}

