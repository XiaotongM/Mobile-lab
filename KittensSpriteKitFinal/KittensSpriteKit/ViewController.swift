//
//  ViewController.swift
//  KittensSpriteKit
//
//  Created by Xiaotong Ma on 2019/4/17.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import UIKit
import Speech
import SpriteKit
import ApiAI
import AVFoundation
import PaperOnboarding

class ViewController: UIViewController, SKViewDelegate, SFSpeechRecognizerDelegate, AVAudioRecorderDelegate {
    
    // My speech bubble
    @IBOutlet weak var myBubble: UIImageView!
    @IBOutlet weak var mySpeechLabel: UILabel!
    
    // Cat speech bubble
    @IBOutlet weak var catBubble: UIImageView!
    @IBOutlet weak var catLabel: UILabel!
    
    @IBOutlet weak var speechLabel: SpeechBubbleView!
    
    @IBOutlet weak var red: UIView!
    
    
    func moveRight(view:UIView){
        view.frame.origin.x = 0
        if view.frame.size.width < 360{
            view.frame.size.width += 10}
    }
    
    func moveLeft(view:UIView){
        view.frame.size.width -= 10
        view.frame.origin.x = 0
    }
    
    func showIncomingMessage(detectedText: String) {
        let label =  catLabel!
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = detectedText
        
        let halfScreen = view.frame.width / 2
        
//        let constraintRect = CGSize(width: halfScreen - 10.0,
//                                    height: halfScreen / 0.75)
        
        let constraintRect = CGSize(width: view.frame.width / 2.0 + 20,
                                    height: view.frame.height / 10.0 )
        
        let boundingBox = detectedText.boundingRect(with: constraintRect,
                                                    options: .usesLineFragmentOrigin,
                                                    attributes: [.font: label.font],
                                                    context: nil)
        
        label.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        let bubbleImageSize = CGSize(width: label.frame.width + 28,
                                     height: label.frame.height + 20)
    
        
//        let incomingMessageView = UIImageView(frame:
//            CGRect(x: 20,
//                   y: view.frame.height - bubbleImageSize.height - 300,
//                   width: bubbleImageSize.width,
//                   height: bubbleImageSize.height))
        
        catBubble.frame = CGRect(x: 40,
                           y: view.frame.height - bubbleImageSize.height - 260,
                           width: bubbleImageSize.width,
                           height: bubbleImageSize.height)
        
//        let bubbleImage = UIImage(named: "incoming-message-bubble")?
//            .resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21))
//
//        incomingMessageView.image = bubbleImage
//
//        view.addSubview(incomingMessageView)
        
        label.center = catBubble.center
//        view.addSubview(label)
    }
    
    
    func showOutgoingMessage(ChipResponse: String) {
        // let label =  UILabel()
        let label = mySpeechLabel!
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = NSTextAlignment.left
        label.text = ChipResponse
        
        let halfScreen = view.frame.width / 2
        
//        let constraintRect = CGSize(width: halfScreen - 10.0,
//                                    height: halfScreen / 0.75)
        
        let constraintRect = CGSize(width: view.frame.width / 3.0 + 20,
                                    height: view.frame.height / 10.0 )
        
        let boundingBox = ChipResponse.boundingRect(with: constraintRect,
                                                    options: .usesLineFragmentOrigin,
                                                    attributes: [.font: label.font],
                                                    context: nil)
        
        label.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        let bubbleImageSize = CGSize(width: label.frame.width + 28,
                                     height: label.frame.height + 20)
        
//        let incomingMessageView = UIImageView(frame:
//            CGRect(x: view.frame.width / 2 - 50,
//                   y: view.frame.height - bubbleImageSize.height - 700,
//                   width: bubbleImageSize.width,
//                   height: bubbleImageSize.height))
        
        myBubble.frame =  CGRect(x: view.frame.width / 3 + 30,
                                 y: (view.frame.height - bubbleImageSize.height) / 6 ,
                                 width: bubbleImageSize.width,
                                 height: bubbleImageSize.height)
            
//        let bubbleImage = UIImage(named: "outgoing-message-bubble")?
//            .resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21))
//
//        incomingMessageView.image = bubbleImage
        
//        view.addSubview(incomingMessageView)
//
        label.center = myBubble.center
        // view.addSubview(label)
    }
    

    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var recorder: AVAudioRecorder!
    

    @IBOutlet weak var detectedText: UILabel!
    @IBOutlet weak var sceneView: SKView!
    @IBOutlet weak var ChipResponse: UILabel!
    @IBOutlet weak var messageField: UITextField!
    
    
    @IBAction func sendMessagetoChip(_ sender: Any) {
        let request = ApiAI.shared().textRequest()
        
        if let text = self.messageField.text, text != "" {
            request?.query = text
        } else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.speech {
                self.speechAndText(text: textResponse)
                self.showOutgoingMessage(ChipResponse:textResponse)
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        messageField.text = ""
    
    }
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.ChipResponse.text = text
        }, completion: nil)
    }
    
    var mostRecentlyProcessedSegmentDuration: TimeInterval = 0
    
    var scene: catScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 181/255, green: 164/255, blue: 255/255, alpha: 1.0)

        self.requestSpeechAuthorization()
        if self.recorder != nil {
            return
        }
        
        // Set the image on the bubble
        myBubble.image = UIImage(named: "outgoing-message-bubble")?
            .resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21))
        
        catBubble.image = UIImage(named: "incoming-message-bubble")?
            .resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21))
    }
    
    
    
    @IBAction func AnimateCat(_ sender: Any) {
        if let scene = self.scene{
            scene.normalCat()
            self.showIncomingMessage(detectedText: "Say something...")
            self.showOutgoingMessage(ChipResponse:"I am listening...")
        }
    }
    

    @IBAction func ChatwithKitten(_ sender: Any) {
        if let scene = self.scene{
            scene.answerQuestionKitten()
        }
        
        let duration = 2.0
        UIView.animate(withDuration: duration, delay:0, options:.curveLinear,animations: {
            self.moveLeft(view: self.red)
            // self.red.frame.origin.x = 0
        },completion: nil)
        
    }
    
    
    @IBAction func FeedKitten(_ sender: Any) {
        if let scene = self.scene{
            scene.FeedAction()
        }
        
        let duration = 2.0
        UIView.animate(withDuration: duration, delay:0, options:.curveLinear,animations: {
            self.moveRight(view: self.red)
        },completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scene = catScene(size: CGSize(width: self.sceneView.frame.size.width, height: self.sceneView.frame.size.height))
        self.sceneView.presentScene(scene)
        
        self.showIncomingMessage(detectedText: "Say something...")
        self.showOutgoingMessage(ChipResponse:"I am listening...")
        
    }


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
                self.detectedText.text = bestString
                
                self.showIncomingMessage(detectedText: bestString)

                if let lastSegment = result.bestTranscription.segments.last,
                    lastSegment.duration > self.mostRecentlyProcessedSegmentDuration {
                    self.mostRecentlyProcessedSegmentDuration = lastSegment.duration

                    /////////////////////////////////////////////////////////////////////
                    // Get last spoken word.
                    // Process request here.

                    let string = lastSegment.substring

                    if string.lowercased() == "hello" {
                        if let scene = self.scene{
                            scene.helloKitten()
                        }
                    } else if string.lowercased() == "talk" {
                        if let scene = self.scene{
                            scene.answerQuestionKitten()
                        }
                    } else if string.lowercased() == "disappear" {

                    }

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
}

