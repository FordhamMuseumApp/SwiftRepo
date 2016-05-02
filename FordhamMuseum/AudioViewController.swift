//
//  AudioViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 4/13/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var audioTableView: UITableView!
    @IBOutlet weak var currentAudioLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    let pause = UIImage(named: "Pause-100") as UIImage?
    let play = UIImage(named: "Play-100") as UIImage?
    
    var art:[NSDictionary]?
        
    var audioPlayer = AVPlayer()
    var isPlaying = false
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Use this: "http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmQuery/Hist/audioa^,^any^or/title!audio!audioa!date!cultur!image/nosort/1024/0/0/0/0/0/json" to return a dictionary of objects with audio files*/
        
        audioTableView.dataSource = self
        audioTableView.delegate = self
        audioTableView.tableFooterView = UIView(frame: CGRectZero) // limits excess tableview cells
        
        apiCall()
        
        currentAudioLabel.text = "Now Playing: "
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let art = art{
            //   print(art.count)
            return art.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("audioCell", forIndexPath: indexPath) as! AudioTableViewCell
        let piece = art![indexPath.row]
        let title = piece["title"] as! String
        let speaker = piece["audioa"] as! String
        let number = piece["audiob"] as! String
        
        cell.titleLabel.text = title
        cell.speakerLabel.text = speaker
        cell.numberLabel.text = number
        // print(title)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // print("tapped")
        let piece = art![indexPath.row]
        let speaker = piece["audioa"] as! String
        currentAudioLabel.text = "Now Playing: \(speaker)"
        let path = piece["audio"]
        let urlStr : NSString = path!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url: NSURL = NSURL(string: urlStr as String)!
        let audio = (url)
        print(audio)
        
        let playerItem = AVPlayerItem(URL: audio)
        audioPlayer = AVPlayer(playerItem:playerItem)
        audioPlayer.rate = 1.0
        
        if let pointer = piece["pointer"]{
            let imagePath = "http://libdigcoll2.library.fordham.edu/utils/getthumbnail/collection/Hist/id/\(pointer)"
            let imageUrl: NSURL = NSURL(string: imagePath as String)!
            
            audioPlayer.play()
            isPlaying = true
            playButton.setImage(pause, forState: .Normal)
        }
        
    }
    
    @IBAction func playPressed(sender: AnyObject) {
        if isPlaying {
            audioPlayer.pause()
            isPlaying = false
            playButton.setImage(play, forState: .Normal)
        } else {
            audioPlayer.play()
            isPlaying = true
            playButton.setImage(pause, forState: .Normal)
        }
    }
    
    
    
    func apiCall() {
        
        //Default
        let api : NSString = "http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmQuery/Hist/audioa^,^any^or/title!audio!audioa!audiob!cultur!image/audiob/1024/0/0/0/0/0/json"
        
        let urlStr : NSString = api.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        // print(urlStr)
        let url: NSURL = NSURL(string: urlStr as String)!
        let request = NSURLRequest(
            URL: url,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                    self.art = responseDictionary["records"] as? [NSDictionary]
                    var descriptor: NSSortDescriptor = NSSortDescriptor(key: "audiob", ascending: true)
                    self.art = responseDictionary["records"]?.sortedArrayUsingDescriptors([descriptor]) as? [NSDictionary]
                    self.audioTableView.reloadData()
                    
                }
            }
        })
        
        task.resume()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
