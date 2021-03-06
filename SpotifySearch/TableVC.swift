//
//  ViewController.swift
//  SpotifySearch
//
//  Created by Laticia Chance on 11/6/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation

var player = AVAudioPlayer()

struct post {
    let image : UIImage!
    let name : String!
    let previewurl: String!
}

class TableVC: UITableViewController, UISearchBarDelegate {
    
//    var searchURL = "https://api.spotify.com/v1/search?q=Solange&type=track&offset=20"
    var searchURL = String()

    var posts = [post]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        let keywords = searchBar.text
        
        //if (keywords?.contains(" "))! {
           let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")

        //}
        
        searchURL = "https://api.spotify.com/v1/search?q=\(finalKeywords!)&type=track&offset=20"
        callAPI(url: searchURL)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // callAPI(url: searchURL)
    }
    
    func callAPI(url: String) {
        
        Alamofire.request(url).responseJSON {
            response in
            
            //print(response.result.value!)
            
            
            self.parseData(JSONData: response.data!)
            
        }
        
    }
    
    func parseData(JSONData: Data) {
        
        guard let jsonObject = JSON(data: JSONData).dictionary else {return}
        
        if let tracks = jsonObject["tracks"]?.dictionary {
            if let items = tracks["items"]?.array {
                
                for i in 0..<items.count {
                    let item = items[i].dictionary
                    
                    let name = item?["name"]?.stringValue
                    let previewURL = item?["preview_url"]?.stringValue
                    
                    
                    if let album = item?["album"] {
                        
                        let images = album["images"]
                        let imageData = images[0]
                        
                        let mainImageURL = URL(string: imageData["url"].stringValue)
                        let mainImageData = NSData(contentsOf: mainImageURL!)
                
                        let mainIMG = UIImage(data: mainImageData! as Data)
                        
                        self.posts.append(post.init(image: mainIMG, name: name, previewurl: previewURL))
                        self.tableView.reloadData()
                        
                    }
                    
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        mainImageView.image = posts[indexPath.row].image
        
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        mainLabel.text = posts[indexPath.row].name
        
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let VC = segue.destination as! AudioVC
        
        VC.image = posts[indexPath!].image
        VC.songTitleText = posts[indexPath!].name
        VC.mainPreviewURL = posts[indexPath!].previewurl
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

