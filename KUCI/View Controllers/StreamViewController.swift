//
//  StreamViewController.swift
//  KUCI
//
//  Created by Nealon Young on 6/4/14.
//  Copyright (c) 2014 Nealon Young. All rights reserved.
//

import AVFoundation
import MediaPlayer
import QuartzCore
import UIKit

class StreamViewController : UIViewController {
    
    @IBOutlet var playButton: UIButton
    @IBOutlet var titleLabel: UILabel
    @IBOutlet var hostLabel: UILabel
    
    var playing = false
    var player = MPMoviePlayerController(contentURL: NSURL(string: "http://streamer.kuci.org:8000/high"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        var sessionError = NSError()
        
        var error : NSError?
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: &error)
        AVAudioSession.sharedInstance().setActive(true, error: &error)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleStream:", name: "toggleStream", object: nil)
        
        self.updateCurrentShow()
        NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: "updateCurrentShow", userInfo: nil, repeats: true)
    }
    
    func updateCurrentShow() {
        ScheduleParser.currentShowWithCompletion { (show: Show?) in
            if show {
                self.titleLabel.text = show!.title
                self.hostLabel.text = "with \(show!.host)"
            } else {
                self.titleLabel.text = "No program info"
                self.hostLabel.text = ""
            }
        }
    }
    
    @IBAction func playButtonPressed() {
        toggleStream(nil)
    }
    
    func toggleStream(notification: NSNotification?) {
        if playing {
            player.pause()
            playButton.setBackgroundImage(UIImage(named: "Play"), forState: .Normal)
        } else {
            player.play()
            playButton.setBackgroundImage(UIImage(named: "Pause"), forState: .Normal)
        }
        
        playing = !playing
    }
}