//
//  CollectionViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 3/10/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit
import AFNetworking

var window: UIWindow?

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MenuViewControllerDelegate, SearchViewControllerDelegate{
    @IBOutlet weak var myCV: UICollectionView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var twitterButton: UIBarButtonItem!
    @IBOutlet weak var audioButton: UIBarButtonItem!
    @IBOutlet weak var searchLabel: UILabel!
    
    
    var art:[NSDictionary]?
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    var endpoint = "0"
    var specie = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCV.dataSource = self
        myCV.delegate = self
        
        apiCall()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        apiCall()
        
        // Allow for editable label presentation:
        searchLabel.text = "Catalog of Museum Objects: \(specie)"
        
    }
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let art = art{
         //   print(art.count)
            return art.count
        } else {
            return 0
        }
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
        
        let piece = art![indexPath.row]
        let title = piece["title"] as! String
       // print(title)
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        if let pointer=piece["pointer"]{
            //print(pointer)
            let imagePath = "http://libdigcoll2.library.fordham.edu:2012/cgi-bin/getimage.exe?CISOROOT=/Hist&CISOPTR=\(pointer)&DMSCALE=1.25000&DMWIDTH=90&DMHEIGHT=90&DMX=0&DMY=0&DMTEXT=&REC=1&DMTHUMB=1&DMROTATE=0%27"
            let imageUrl: NSURL = NSURL(string: imagePath as String)!
           // print(imageUrl)
            cell.myImage.setImageWithURL(imageUrl)
        }
        cell.layer.borderColor = UIColor.blueColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.backgroundColor = UIColor.grayColor() // make cell more visible in our example project
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        // print("You selected cell #\(indexPath.item)!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "menuSegue"{
            let menu = segue.destinationViewController as! MenuViewController
            menu.delegate = self
        }
        if segue.identifier == "detailSegue"{
            let cell = sender as! UICollectionViewCell
            let indexPath = myCV.indexPathForCell(cell)
            let detail = segue.destinationViewController as! DetailViewController
            detail.piece = art![indexPath!.row]
        }
        if segue.identifier == "searchSegue"{
            let search = segue.destinationViewController as! SearchViewController
            search.delegate = self
            search.specie = specie
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func sendValues(endpnt: NSString, spcie: NSString){
        print(endpnt)
        endpoint = endpnt as String
        specie = spcie as String
        myCV.reloadData()
        
    }
    
    func apiCall() {
        var api : NSString = "http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmQuery/Hist/date^\(endpoint)^any^or/title!descri!covera!date!langua!image/nosort/1024/0/0/0/0/0/json"
        var urlStr : NSString = api.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        // print(urlStr)
        var url: NSURL = NSURL(string: urlStr as String)!
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
                    self.art = responseDictionary["records"] as! [NSDictionary]
                    // print(self.art)
                    self.myCV.reloadData()
                                                                                
                }
            }
        })
        
        task.resume()
    }
    

}


