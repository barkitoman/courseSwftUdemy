//
//  PianoViewController.swift
//  CourseInUdemy
//
//  Created by Julian Barco on 9/9/19.
//  Copyright © 2019 Julian Barco. All rights reserved.
//

import UIKit
import AVFoundation

class PianoViewController: UIViewController {

    
    @IBOutlet var sound: [UIButton]!
    @IBOutlet var keySound: [UIButton]!
    var player : AVAudioPlayer = AVAudioPlayer()
    var loop1 : AVAudioPlayer = AVAudioPlayer()
    var loop2 : AVAudioPlayer = AVAudioPlayer()
    var loop3 : AVAudioPlayer = AVAudioPlayer()
    var stopLoop1 = true
    var stopLoop2 = true
    var stopLoop3 = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func activeSound(_ sender: UIButton) {
        switch (sender as AnyObject).tag {
        case 1:
            self.takeLoop1(sound: "loop1")
            if !stopLoop1 {
                sound[0].alpha = 1
                sound[3].alpha = 0.5
                sound[6].alpha = 0.5
            }else{
                sound[0].alpha = 0.5
            }
        case 2:
            self.takeLoop2(sound: "loop2")
            if !stopLoop2 {
                sound[1].alpha = 1
                sound[4].alpha = 0.5
                sound[7].alpha = 0.5
            }else{
                sound[1].alpha = 0.5
            }
        case 3:
            self.takeLoop3(sound: "loop3")
            if !stopLoop3 {
                sound[2].alpha = 1
                sound[5].alpha = 0.5
                sound[8].alpha = 0.5
            }else{
                sound[2].alpha = 0.5
            }
        case 4:
            self.takeLoop1(sound: "loop4")
            if !stopLoop1 {
                sound[3].alpha = 1
                sound[0].alpha = 0.5
                sound[6].alpha = 0.5
            }else{
                sound[3].alpha = 0.5
            }
        case 5:
           self.takeLoop2(sound: "loop5")
           if !stopLoop2 {
                sound[4].alpha = 1
                sound[1].alpha = 0.5
                sound[7].alpha = 0.5
           } else {
                sound[4].alpha = 0.5
            }
        case 6:
            self.takeLoop3(sound: "loop6")
            if !stopLoop3 {
                sound[5].alpha = 1
                sound[2].alpha = 0.5
                sound[8].alpha = 0.5
            }else{
                sound[5].alpha = 0.5
            }
        case 7:
            self.takeLoop1(sound: "loop7")
            if !stopLoop1 {
                sound[6].alpha = 1
                sound[0].alpha = 0.5
                sound[3].alpha = 0.5
            }else{
                sound[6].alpha = 0.5
            }
        case 8:
            self.takeLoop2(sound: "loop8")
            if !stopLoop2 {
                sound[7].alpha = 1
                sound[1].alpha = 0.5
                sound[4].alpha = 0.5
            } else {
                sound[7].alpha = 0.5
            }
        case 9:
            self.takeLoop3(sound: "loop9")
            if !stopLoop3 {
                sound[8].alpha = 1
                sound[2].alpha = 0.5
                sound[5].alpha = 0.5
            }else{
                sound[8].alpha = 0.5
            }
        default:
            break
        }
    }
    
    
    @IBAction func releaseKey(_ sender: Any) {
        switch (sender as AnyObject).tag {
            case 1:
                keySound[0].backgroundColor = UIColor.white
            case 2:
                keySound[1].backgroundColor = UIColor.white
            case 3:
                keySound[2].backgroundColor = UIColor.white
            case 4:
                keySound[3].backgroundColor = UIColor.white
            case 5:
                keySound[4].backgroundColor = UIColor.white
            case 6:
                keySound[5].backgroundColor = UIColor.white
            case 7:
                keySound[6].backgroundColor = UIColor.white
            case 8:
                keySound[7].backgroundColor = UIColor.white
            default:
                break
        }
    }
    
    
    @IBAction func activeKeySound(_ sender: Any) {
        switch (sender as AnyObject).tag {
            case 1:
                keySound[0].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
                takeKey(sound: "do")
            case 2:
                keySound[1].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
                takeKey(sound: "re")
            case 3:
                keySound[2].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
                takeKey(sound: "mi")
            case 4:
                keySound[3].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
                takeKey(sound: "fa")
            case 5:
                keySound[4].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
                takeKey(sound: "sol")
            case 6:
                keySound[5].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
                takeKey(sound: "la")
            case 7:
                keySound[6].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
                takeKey(sound: "si")
            case 8:
                keySound[7].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
                takeKey(sound: "do_octava")
            default:
                break
        }
    }
    
    
    func takeKey(sound: String){
        do {
            let audioPath = Bundle.main.path(forResource: sound, ofType: "wav")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            player.prepareToPlay()
            player.play()
            player.volume = 5
        } catch let error as NSError {
            print("there was a error an playing sound", error.localizedDescription)
        }
    }
    
    func takeLoop1(sound: String){
        do {
            let audioPath = Bundle.main.path(forResource: sound, ofType: "mp3")
            try loop1 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            if stopLoop1 {
                loop1.prepareToPlay()
                loop1.play()
                loop1.numberOfLoops = -1
                self.stopLoop1 = false
            }else{
                loop1.stop()
                self.stopLoop1 = true
            }
            
        } catch let error as NSError {
            print("there was a error an playing sound", error.localizedDescription)
        }
    }
    
    func takeLoop2(sound: String){
        do {
            let audioPath = Bundle.main.path(forResource: sound, ofType: "mp3")
            try loop2 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            if stopLoop2 {
                loop2.prepareToPlay()
                loop2.play()
                loop2.numberOfLoops = -1
                stopLoop2 = false
            }else{
                loop2.stop()
                stopLoop2 = true

            }
        } catch let error as NSError {
            print("there was a error an playing sound", error.localizedDescription)
        }
    }
    
    func takeLoop3(sound: String){
        do {
            let audioPath = Bundle.main.path(forResource: sound, ofType: "mp3")
            try loop3 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            if stopLoop3 {
                loop3.prepareToPlay()
                loop3.play()
                loop3.numberOfLoops = -1
                stopLoop3 = false
            }else{
                loop3.stop()
                stopLoop3 = true
            }
        } catch let error as NSError {
            print("there was a error an playing sound", error.localizedDescription)
        }
    }
    
}
