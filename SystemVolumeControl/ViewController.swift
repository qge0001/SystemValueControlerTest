//
//  ViewController.swift
//  SystemVolumeControl
//
//  Created by ma c on 2019/2/23.
//  Copyright © 2019年 ma c. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var volumeLabel: UILabel!
    
    var volumeSlider:UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.volumeLabel.alpha = 0
        
        print("output volume : \(AVAudioSession.sharedInstance().outputVolume)");
        
        let volumeV = MPVolumeView(frame: CGRect(x: -3, y: -3, width: 1, height: 1))
        for view in volumeV.subviews{
            if view is UISlider{
                self.volumeSlider = (view as! UISlider)
            }
        }
        self.view.addSubview(volumeV)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.volumeChange(_:)) , name:Notification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification") , object: nil)
    }
    
    @objc func volumeChange(_ notification:NSNotification) {
        let userInfo = notification.userInfo!
        let volume = userInfo["AVSystemController_AudioVolumeNotificationParameter"] as! Double
        print("slider volume:\(self.volumeSlider.value)")
        print("volume:\(volume)")
        self.showVolumeText(volume)
    }
    
    @IBAction func addVolume(_ sender: UIButton) {
        self.volumeSlider.value += 1/16
        
    }
    
    @IBAction func reduceVolume(_ sender: UIButton) {
        self.volumeSlider.value -= 1/16

    }

    func showVolumeText(_ volume:Double){
        self.volumeLabel.text = "Volume:\(volume)"
        self.volumeLabel.alpha = 1
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(ViewController.dismissSlider), with: nil, afterDelay: 2)
    }

    @objc func dismissSlider(){
        self.volumeLabel.alpha = 0
    }
    
}

