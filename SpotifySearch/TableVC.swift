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
    
    let searchURL = "https://api.spotify.com/v1/search?q=Solange&type=track&offset=20"
    var trackTitle = [String]()
    
    typealias JSONStandard = [String : AnyObject]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        callAPI(url: searchURL)
    }
    
    func callAPI(url: String) {
        
        Alamofire.request(url).responseJSON {
            response in
        
            self.parseData(JSONData: response.data!)
            
        }
        
    }

    func parseData(JSONData: Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            print(readableJSON)
            
            if let tracks = readableJSON["tracks"] as? JSONStandard {
                if let items = tracks["items"] {

                    for i in 0..<items.count {
                        
                        let item = items[i] as! JSONStandard
                        let names = item["name"] as! String
                        
                        self.trackTitle.append(names)
                        
                    }
                }
                
            }
            
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

