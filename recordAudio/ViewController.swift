//
//  ViewController.swift
//  recordAudio
//
//  Created by 廖昱晴 on 2021/3/3.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    
//    var recordHelper: RecordHelper?
    let recordHelper = {
        return RecordHelper()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        recordHelper = RecordHelper() //產生RecordHelper實體
    }

    @IBAction func recordAudio(_ sender: UIButton) {
        recordHelper.recordAudio()
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        recordHelper.stopRecording()
    }
    
    @IBAction func playRecordedSound(_ sender: UIButton) {
        recordHelper.playRecordedSound()
    }
    
    @IBAction func stopPlaying(_ sender: UIButton) {
        recordHelper.stopPlaying()
    }
    
}

