//
//  DetailViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 3/10/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {

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
    
    var piece: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiCall()
        
        contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        contentView.layer.cornerRadius = 20
        
        print(piece!)
        
        detailName.text = self.piece!["title"] as? String
        materialHeightLabel.text = piece!["cultur"] as? String
        dateLabel.text = piece!["date"] as? String
        collectionCollectionNumberLabel.text = piece!["langua"] as? String
        museumLabel.text = piece!["descri"] as? String
        
        cateloLabel.preferredMaxLayoutWidth = cateloLabel.frame.size.width
        languaLabel.preferredMaxLayoutWidth = languaLabel.frame.size.width
        dateLabel.preferredMaxLayoutWidth = dateLabel.frame.size.width
        detailName.preferredMaxLayoutWidth = detailName.frame.size.width
        materialHeightLabel.preferredMaxLayoutWidth = materialHeightLabel.frame.size.width
        collectionCollectionNumberLabel.preferredMaxLayoutWidth = collectionCollectionNumberLabel.frame.size.width
        museumLabel.preferredMaxLayoutWidth = museumLabel.frame.size.width
        
        if let pointer = piece!["pointer"]{
            let imagePath = "http://libdigcoll2.library.fordham.edu/utils/getthumbnail/collection/Hist/id/\(pointer)"
            let imageUrl: NSURL = NSURL(string: imagePath as String)!
            detailImage.setImageWithURL(imageUrl)
        }
        
        // Do any additional setup after loading the view.
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
                    self.languaLabel.text = ""
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
