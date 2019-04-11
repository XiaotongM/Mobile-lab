//
//  ViewController.swift
//  VoiceDetection
//
//  Created by Xiaotong Ma on 2019/4/10.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import UIKit
import Speech

var fishImages: [UIImageView] = []

class ViewController: UIViewController, SFSpeechRecognizerDelegate, AVAudioRecorderDelegate {
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var recorder: AVAudioRecorder!
    
    @IBOutlet weak var detectedTextLabel: UILabel!
    @IBAction func decrease(_ sender: UIButton) {
        deleteFishes()
    }
    
    var mostRecentlyProcessedSegmentDuration: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.20, green:0.24, blue:0.31, alpha:1.0)
        self.requestSpeechAuthorization()
        
        if self.recorder != nil {
            return
        }
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        for fish in 0...50 {
             generateAnimatedViews()
        }
//            (0...30).forEach { (_) in
//                generateAnimatedViews()
//            }
    }
    

//    @objc func handleTap() {
//    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    print("authorized")
                    self.recordAndRecognizeSpeech()
                case .denied:
                    print("denied")
                case .restricted:
                    print("restricted")
                case .notDetermined:
                    print("notDetermined")
                @unknown default:
                    return
                }
            }
        }
    }
    
    func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            self.sendAlert(message: "There has been an audio engine error.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            self.sendAlert(message: "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            self.sendAlert(message: "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                self.detectedTextLabel.text = bestString
                
                if let lastSegment = result.bestTranscription.segments.last,
                    lastSegment.duration > self.mostRecentlyProcessedSegmentDuration {
                    self.mostRecentlyProcessedSegmentDuration = lastSegment.duration
                    
                    /////////////////////////////////////////////////////////////////////
                    // Get last spoken word.
                    // Process request here.
                    
                    let string = lastSegment.substring
                    
                    if string.lowercased() == "much" {
                        self.deleteFishes()
                    } else if string.lowercased() == "back" {
                        for i in 0...50 {
                            self.generateAnimatedViews()
                        }
                    } else if string.lowercased() == "disappear" {
                        self.disappear()
                    }
                    

//                        self.recorder?.updateMeters()
//                        let level = self.recorder.averagePower(forChannel: 0)
//                        print("Level Number: ", level)
//                        if (level < -30) {
//                            for i in 0...50 {
//                                self.generateAnimatedViews()
//                            }
//                        } else if (level < -20) {
//                            self.deleteFishes()
//                        } else if (level < 0) {
//                            self.disappear()
//                        }
                    
                    
                    /////////////////////////////////////////////////////////////////////
                }
                
            } else if let error = error {
                self.sendAlert(message: "There has been a speech recognition error.")
                print(error)
            }
            
        })
    }
    
    
    func sendAlert(message: String) {
        let alert = UIAlertController(title: "Speech Recognizer Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    
    fileprivate func generateAnimatedViews() {
        let image = drand48() > 0.5 ? UIImage(named: "pufferfish")! : UIImage(named: "fish")!
        let imageView = UIImageView(image: image)
//        let imageView = UIImageView(image: fish)
//        let image: UIImage = UIImage(named: "pufferfish")!
        
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension * 2.4, height: dimension * 2.4)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.duration = Double(arc4random_uniform(60)+30) / 10
        animation.timeOffset = Double(arc4random_uniform(290))
        animation.repeatCount = Float.infinity
        
        imageView.layer.add(animation, forKey: nil)
        fishImages.append(imageView)
        view.addSubview(imageView)
//        for i in fishImages {
//        view.addSubview(i)
//        }
    }
    
//    func deleteFishes(){
//        for i in fishImages {
//            i.removeFromSuperview()
//        }
//    }
    
    func deleteFishes(){
       for i in 0...40 {
       fishImages[i].removeFromSuperview()
    }
  }
    
    func disappear(){
        for i in 0...50 {
        fishImages[i].removeFromSuperview()
     }
   }
    
//    func addFishes(){
//        for i in fishImages {
//          view.addSubview(i)
//        }
//    }
    
    
}

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x: 0, y: 400))
    
    let endPoint = CGPoint(x: 400, y: 400)
    
//    let randomYShift = 300 + drand48() * 200
    let randomYOffset = CGFloat( arc4random_uniform(500))
    let cp1 = CGPoint(x: 100, y: 100 + randomYOffset)
    let cp2 = CGPoint(x: 300, y: 400 + randomYOffset)
    
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}


class CurvedView: UIView {
    
    override func draw(_ rect: CGRect) {
        //do some fancy curve drawing
        let path = customPath()
        path.lineWidth = 3
        path.stroke()
    }
    
}

