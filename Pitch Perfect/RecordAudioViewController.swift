//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Garima Bothra on 10/05/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import AVKit

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {
    //MARK: IBOutlets
    @IBOutlet weak var recordMessageLabel: UILabel!
    @IBOutlet weak var audioRecordButton: UIButton!
    @IBOutlet weak var audioStopButton: UIButton!

    // MARK: Variables
    var audioRecorder: AVAudioRecorder!
    override func viewDidLoad() {
        super.viewDidLoad()
        audioStopButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    @IBAction func recordButtonPressed(_ sender: Any) {
        recordMessageLabel.text = "Recording in progress"
        audioStopButton.isEnabled = true
        audioRecordButton.isEnabled = false

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopButtonPressed(_ sender: Any) {
        recordMessageLabel.text = "Tap to record"
        audioStopButton.isEnabled = false
        audioRecordButton.isEnabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "recordingComplete", sender: audioRecorder.url)
        } else {
            print("Recording failed!")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "recordingComplete" {
            let editorViewController = segue.destination as! SoundEditorViewController
            let recordedAudioURL = sender as! URL
            editorViewController.recordedAudioURL = recordedAudioURL
        }
    }
}

