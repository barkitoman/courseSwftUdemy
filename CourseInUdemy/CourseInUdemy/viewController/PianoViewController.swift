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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func activeSound(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            <#code#>
        default:
            <#code#>
        }
    }
    
    
    @IBAction func releaseKey(_ sender: Any) {
    }
    
    
    @IBAction func activeKeySound(_ sender: Any) {
    }
    
    
    func takeKey(sound: String){
        do {
            let audioPath = Bundle.main.path(forResource: sound, ofType: "mp3")
            try <#throwing expression#>
        } catch let error as NSError {
            print("there was a error an playing sound")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
