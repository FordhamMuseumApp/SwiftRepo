//
//  DetailViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 3/10/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit
import AVFoundation
import AFNetworking

class DetailViewController: UIViewController, NSXMLParserDelegate{

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var materialHeightLabel: UILabel!
    @IBOutlet weak var collectionCollectionNumberLabel: UILabel!
    @IBOutlet weak var museumLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cateloLabel: UILabel!
    @IBOutlet weak var languaLabel: UILabel!
    @IBOutlet weak var audioButton: UIButton!
    
    var piece: NSDictionary?
    var aUrl: String?
    var isAudio = false
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    
    var audioPlayer = AVPlayer()
    var isPlaying = false
    
    let pause = UIImage(named: "Pause-100") as UIImage?
    let play = UIImage(named: "Play-100") as UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginParsing()
        
        
        audioButton.hidden = true
        
        self.apiCall()
        
        print(posts[0]["height"]!)
        contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        contentView.layer.cornerRadius = 20
        
        detailName.text = self.piece!["title"] as? String
        materialHeightLabel.text = piece!["cultur"] as? String
        languaLabel.text = piece!["date"] as? String
        collectionCollectionNumberLabel.text = "" as? String
        museumLabel.text = piece!["descri"] as? String
        
        cateloLabel.preferredMaxLayoutWidth = cateloLabel.frame.size.width
        languaLabel.preferredMaxLayoutWidth = languaLabel.frame.size.width
        dateLabel.preferredMaxLayoutWidth = dateLabel.frame.size.width
        detailName.preferredMaxLayoutWidth = detailName.frame.size.width
        materialHeightLabel.preferredMaxLayoutWidth = materialHeightLabel.frame.size.width
        collectionCollectionNumberLabel.preferredMaxLayoutWidth = collectionCollectionNumberLabel.frame.size.width
        museumLabel.preferredMaxLayoutWidth = museumLabel.frame.size.width
        
        if let pointer = piece!["pointer"]{
            // http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmGetImageInfo/Hist/199/xml
            let imagePath = "http://libdigcoll2.library.fordham.edu:2012/cgi-bin/getimage.exe?CISOROOT=/Hist&CISOPTR=\(pointer)&DMSCALE=5&DMWIDTH=\(posts[0]["width"]!)&DMHEIGHT=\(posts[0]["height"]!)&DMX=0&DMY=0&DMTEXT=&REC=1&DMTHUMB=1&DMROTATE=0%27"
            let imageUrl: NSURL = NSURL(string: imagePath as String)!
            detailImage.setImageWithURL(imageUrl)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAudio(sender: AnyObject) {
        if isPlaying {
            audioPlayer.pause()
            isPlaying = false
            self.audioButton.setImage(play, forState: .Normal)
        } else {
            audioPlayer.play()
            isPlaying = true
            self.audioButton.setImage(pause, forState: .Normal)
        }

        
        
        
    }
   
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmGetImageInfo/Hist/199/xml"))!)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("imageinfo")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if element.isEqualToString("width") {
            title1.appendString(string)
        } else if element.isEqualToString("height") {
            date.appendString(string)
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqualToString("imageinfo") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "width")
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "height")
            }
            posts.addObject(elements)
        }
    }
    
    func apiCall() {
     
        let pointer = piece!["pointer"]!
        
        //Default
        var api : NSString = "http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmGetItemInfo/Hist/\(pointer)/json"
        
        // We also want fields: langua, creato, type, and catelo for the detail view controller. We want to sortby dateed
        
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
                    self.piece = responseDictionary
                    print(self.piece)
                    self.cateloLabel.text = self.piece!["catelo"] as? String
                    self.dateLabel.text = self.piece!["langua"] as? String
                    if let audioUrl = self.piece!["audio"] as? String {
                        print("audioset")
                        self.isAudio = true
                       
                        self.aUrl = audioUrl
                        
                        self.audioButton.hidden = false
                        let path = self.aUrl
                        let urlStr : NSString = path!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                        let url: NSURL = NSURL(string: urlStr as String)!
                        let audio = (url)
                        print(audio)
                        let playerItem = AVPlayerItem(URL: audio)
                        self.audioPlayer = AVPlayer(playerItem:playerItem)
                        self.audioPlayer.rate = 1.0
                        self.audioPlayer.pause()
                        
                    }
                }
            }
        })
        
        task.resume()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
