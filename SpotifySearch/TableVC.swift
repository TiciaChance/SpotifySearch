//
//  ViewController.swift
//  SpotifySearch
//
//  Created by Laticia Chance on 11/6/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import Alamofire
//import SwiftyJSON


class TableVC: UITableViewController {
    
    var searchURL = "https://api.spotify.com/v1/search?q=Solange&type=track&offset=20"
    
    typealias JSONStandard = [String : Any]

    override func viewDidLoad() {
        super.viewDidLoad()

        callAPI(url: searchURL)
    }
    
    func callAPI(url: String) {
        
        Alamofire.request(url).responseJSON {
            response in
        
            self.parseData(jsonData: response.data!)
            
        }
        
    }

    func parseData(jsonData: Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! JSONStandard
            print(readableJSON)
        }
        catch {
            print(error)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

