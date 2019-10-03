//
//  ViewController.swift
//  LaunchPiano
//
//  Created by Jorge M. B. on 06/10/18.
//  Copyright © 2018 Jorge M. B. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    
    @IBOutlet weak var pianoStack: UIStackView!
    @IBOutlet weak var launchStack: UIStackView!
    @IBOutlet var sonido: [UIButton]!
    @IBOutlet var nota: [UIButton]!
    
    var player : AVAudioPlayer = AVAudioPlayer()
    var loop1 : AVAudioPlayer = AVAudioPlayer()
    var loop2 : AVAudioPlayer = AVAudioPlayer()
    var loop3 : AVAudioPlayer = AVAudioPlayer()
    var stopLoop1 = true
    var stopLoop2 = true
    var stopLoop3 = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        orientacion()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        orientacion()
    }
    
    func orientacion(){
        if UIDevice.current.orientation.isLandscape{
            pianoStack.isHidden = false
            launchStack.axis = .horizontal
        }else{
            pianoStack.isHidden = true
            launchStack.axis = .vertical
        }
    }
    
    
    @IBAction func piano(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            nota[0].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
            tocarTecla(sonido: "do")
        case 2:
            nota[1].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
            tocarTecla(sonido: "re")
        case 3:
            nota[2].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
            tocarTecla(sonido: "mi")
        case 4:
            nota[3].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
            tocarTecla(sonido: "fa")
        case 5:
            nota[4].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
            tocarTecla(sonido: "sol")
        case 6:
            nota[5].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
            tocarTecla(sonido: "la")
        case 7:
            nota[6].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
            tocarTecla(sonido: "si")
        case 8:
            nota[7].backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 255/255, alpha: 1)
            tocarTecla(sonido: "do_octava")
        default:
            break
        }
        
    }
    
    @IBAction func soltarTecla(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            nota[0].backgroundColor = UIColor.white
        case 2:
            nota[1].backgroundColor = UIColor.white
        case 3:
            nota[2].backgroundColor = UIColor.white
        case 4:
            nota[3].backgroundColor = UIColor.white
        case 5:
            nota[4].backgroundColor = UIColor.white
        case 6:
            nota[5].backgroundColor = UIColor.white
        case 7:
            nota[6].backgroundColor = UIColor.white
        case 8:
            nota[7].backgroundColor = UIColor.white
        default:
            break
        }
    }
    
    
    @IBAction func reproducirLoop(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            tocarLoop1(sonido: "loop1")
            if stopLoop1 == false {
                sonido[0].alpha = 1
                sonido[3].alpha = 0.5
                sonido[6].alpha = 0.5
            }else{
                sonido[0].alpha = 0.5
            }
        case 2:
            tocarLoop2(sonido: "loop2")
            if stopLoop2 == false {
                sonido[1].alpha = 1
                sonido[4].alpha = 0.5
                sonido[7].alpha = 0.5
            }else{
                sonido[1].alpha = 0.5
            }
        case 3:
            tocarLoop3(sonido: "loop3")
            if stopLoop3 == false {
                sonido[2].alpha = 1
                sonido[5].alpha = 0.5
                sonido[8].alpha = 0.5
            }else{
                sonido[2].alpha = 0.5
            }
        case 4:
            tocarLoop1(sonido: "loop4")
            if stopLoop1 == false {
                sonido[0].alpha = 0.5
                sonido[3].alpha = 1
                sonido[6].alpha = 0.5
            }else{
                sonido[3].alpha = 0.5
            }
        case 5:
            tocarLoop2(sonido: "loop5")
            if stopLoop2 == false {
                sonido[1].alpha = 0.5
                sonido[4].alpha = 1
                sonido[7].alpha = 0.5
            }else{
                sonido[4].alpha = 0.5
            }
        case 6:
            tocarLoop3(sonido: "loop6")
            if stopLoop3 == false {
                sonido[2].alpha = 0.5
                sonido[5].alpha = 1
                sonido[8].alpha = 0.5
            }else{
                sonido[5].alpha = 0.5
            }
        case 7:
            tocarLoop1(sonido: "loop7")
            if stopLoop1 == false {
                sonido[0].alpha = 0.5
                sonido[3].alpha = 0.5
                sonido[6].alpha = 1
            }else{
                sonido[6].alpha = 0.5
            }
        case 8:
            tocarLoop2(sonido: "loop8")
            if stopLoop2 == false {
                sonido[1].alpha = 0.5
                sonido[4].alpha = 0.5
                sonido[7].alpha = 1
            }else{
                sonido[7].alpha = 0.5
            }
        case 9:
            tocarLoop3(sonido: "loop9")
            if stopLoop3 == false {
                sonido[2].alpha = 0.5
                sonido[5].alpha = 0.5
                sonido[8].alpha = 1
            }else{
                sonido[8].alpha = 0.5
            }
        default:
            break
        }
    }
    
    func tocarTecla(sonido: String){
        do {
            let audioPath = Bundle.main.path(forResource: sonido, ofType: "wav")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            player.prepareToPlay()
            player.play()
            player.volume = 5
        } catch let error as NSError {
            print("Hubo un error al reproducri el sonido", error.localizedDescription)
        }
    }
    
    func tocarLoop1(sonido: String){
        do {
            let audioPath = Bundle.main.path(forResource: sonido, ofType: "mp3")
            try loop1 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            if stopLoop1 == true {
                loop1.prepareToPlay()
                loop1.play()
                loop1.numberOfLoops = -1
                stopLoop1 = false
            }else{
                loop1.stop()
                stopLoop1 = true
            }
            
            
        } catch let error as NSError {
            print("Hubo un error al reproducri el sonido", error.localizedDescription)
        }
    }
    
    func tocarLoop2(sonido: String){
        do {
            let audioPath = Bundle.main.path(forResource: sonido, ofType: "mp3")
            try loop2 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            if stopLoop2 == true {
                loop2.prepareToPlay()
                loop2.play()
                loop2.numberOfLoops = -1
                stopLoop2 = false
            }else{
                loop2.stop()
                stopLoop2 = true
            }
            
            
        } catch let error as NSError {
            print("Hubo un error al reproducri el sonido", error.localizedDescription)
        }
    }
    
    func tocarLoop3(sonido: String){
        do {
            let audioPath = Bundle.main.path(forResource: sonido, ofType: "mp3")
            try loop3 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            if stopLoop3 == true {
                loop3.prepareToPlay()
                loop3.play()
                loop3.numberOfLoops = -1
                stopLoop3 = false
            }else{
                loop3.stop()
                stopLoop3 = true
            }
            
            
        } catch let error as NSError {
            print("Hubo un error al reproducri el sonido", error.localizedDescription)
        }
    }
    
    
    
}


