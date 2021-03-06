//
//  AudioVC.swift
//  SpotifySearch
//
//  Created by Laticia Chance on 11/8/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioVC : UIViewController {
    
    @IBOutlet weak var mainIMG: UIImageView!
    @IBOutlet weak var backgroundIMG: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    
    var image = UIImage()
    var songTitleText = String()
    var mainPreviewURL = String()
    
    @IBOutlet weak var playPAUSEbutton: UIButton!
    
    override func viewDidLoad() {
        
        songTitle.text = songTitleText
        backgroundIMG.image = image
        mainIMG.image = image
        playPAUSEbutton.setTitle("Pause", for: .normal)
        
        downloadFileFromURL(url: URL(string: mainPreviewURL)!)
        
    }
    
    func play(url : URL) {
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch {
            
            print(error)
        }
        
    }
    
    func downloadFileFromURL(url: URL) {
        
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { customURL, response, error in
            
            self.play(url: customURL!)
        })
        downloadTask.resume()
    }

    @IBAction func PauseButton(_ sender: Any) {
        
        if player.isPlaying {
            player.pause()
            playPAUSEbutton.setTitle("Play", for: .normal)
        } else {
            player.play()
            playPAUSEbutton.setTitle("Pause", for: .normal)
        }
    }
}
