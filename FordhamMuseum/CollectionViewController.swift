//
//  CollectionViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 3/10/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit
var window: UIWindow?

class CollectionViewController: UIViewController {

    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var twitterButton: UIBarButtonItem!
    @IBOutlet weak var audioButton: UIBarButtonItem!
    
    var endpoint = "greek"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var api : NSString = "http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmQuery/Hist/date^\(endpoint)^all^and/title!descri!covera!date!langua!image/nosort/1024/0/0/0/0/0/json"
        var urlStr : NSString = api.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        var url: NSURL = NSURL(string: urlStr as String)!
        print(url)
        let request = NSURLRequest(
            URL: url,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            print("response: \(responseDictionary)")
                            
                            
                    }
                }
        })
        task.resume()
        
        // Do any additional setup after loading the view.
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
