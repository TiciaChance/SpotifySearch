//
//  AudioVC.swift
//  SpotifySearch
//
//  Created by Laticia Chance on 11/8/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import Foundation
import UIKit

class AudioVC : UIViewController {
    
    @IBOutlet weak var mainIMG: UIImageView!
    @IBOutlet weak var backgroundIMG: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    
    var image = UIImage()
    var songTitleText = String()
    var mainPreviewURL = String()
    
    override func viewDidLoad() {
        songTitle.text = songTitleText
        backgroundIMG.image = image
        mainIMG.image = image
    }
}
