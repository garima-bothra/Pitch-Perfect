//
//  SoundEditorViewController.swift
//  Pitch Perfect
//
//  Created by Garima Bothra on 11/05/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import AVKit

class SoundEditorViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var slowAudioButton: UIButton!
    @IBOutlet weak var fastAudioButton: UIButton!
    @IBOutlet weak var highPitchAudioButton: UIButton!
    @IBOutlet weak var lowPitchAudioButton: UIButton!
    @IBOutlet weak var echoAudioButton: UIButton!
    @IBOutlet weak var reverbAudioButton: UIButton!
    @IBOutlet weak var stopAudioButton: UIButton!
    //MARK: Variables
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }

    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }

    @IBAction func playSoundButtonPressed(sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }

    @IBAction func stopSoundButtonPressed(sender: UIButton) {
        stopAudio()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected objec\t to the new view controller.
    }
    */

}
