//
//  recordHelper.swift
//  recordAudio
//
//  Created by 廖昱晴 on 2021/3/3.
//

import Foundation
import AVFoundation

enum audioSessionMode {
    case record
    case play
}

class RecordHelper: NSObject, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var isRecording = false
    
    override init() {
        super.init()
        
        // init audioRecorder
        let fileName = "User.wav" //錄音的檔名
        let path = NSHomeDirectory() + "/Documents/" + fileName //錄音檔案路徑
        let url = URL(fileURLWithPath: path)
        let recordSettings: [String:Any] = [
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0] //錄音設定
        do {
            try audioRecorder = AVAudioRecorder(url: url, settings: recordSettings) //製作audioRecorder元件
            audioRecorder?.delegate = self
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recordAudio() {
        settingAudioSession(toMode: .record) //調整音訊工作階段
        audioRecorder?.prepareToRecord() //準備錄音
        audioRecorder?.record() //開始錄音
        isRecording = true
    }
    
    func stopRecording() {
        audioRecorder?.stop() //停止錄音
        isRecording = false
        settingAudioSession(toMode: .play) //調整音訊工作階段
    }
    
    func playRecordedSound() {
        if isRecording == false {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
            audioPlayer?.play()
        }
    }
    
    func stopPlaying() {
        if isRecording == false {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
        }
    }
    
    func settingAudioSession(toMode mode: audioSessionMode) {
        audioPlayer?.stop()
        let session = AVAudioSession.sharedInstance() //音訊工作階段
        do {
            //調整session狀態
            switch mode {
            case .record:
                try session.setCategory(.playAndRecord, mode: .default, options: [])
            case .play:
                try session.setCategory(.playback, mode: .default, options: [])
            }
            try session.setActive(false)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //audioRecorder Delegate的方法
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag == true { //停止錄音後
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: recorder.url) //製作audioPlayer元件
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
}
