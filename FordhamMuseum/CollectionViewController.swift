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

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MenuViewControllerDelegate, UISearchBarDelegate{
    @IBOutlet weak var myCV: UICollectionView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var twitterButton: UIBarButtonItem!
    @IBOutlet weak var audioButton: UIBarButtonItem!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    var viewType: String?
    var searchBar = UISearchBar()
    
    var art:[NSDictionary]?
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    var endpoint = "0"
    var specie = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCV.dataSource = self
        myCV.delegate = self
        
        apiCall()
        
        cancelButton.hidden = true
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search"
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        apiCall()
        
        // Allow for editable label presentation:
        searchLabel.text = "Catalog of Museum Objects: \(specie)"
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        cancelButton.hidden = false
        searchLabel.hidden = true
        
        //searchLabel.text = "Cancel"
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let term = searchBar.text! as String
        let formattedTerm = term.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        endpoint = formattedTerm
        searchLabel.hidden = false
        cancelButton.hidden = true
        searchLabel.text = "Catalog of Museum Objects: \(term)"
        specie = term
        viewType = "search"
        apiCall()
        searchBar.resignFirstResponder()
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        searchBar.resignFirstResponder()
        cancelButton.hidden = true
        searchLabel.hidden = false
        
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
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        if let pointer=piece["pointer"]{
            //print(pointer)
            let imagePath = "http://libdigcoll2.library.fordham.edu/utils/getthumbnail/collection/Hist/id/\(pointer)"
            let imageUrl = NSURL(string: imagePath as String)!
           // print(imageUrl)
            cell.myImage.setImageWithURL(imageUrl)
        }
    
        
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5) // make cell more visible in our example project
        
        // Code trying to make shadows
            
        /* let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 7).CGPath
        shadowLayer.fillColor = UIColor.whiteColor().CGColor
                
        shadowLayer.shadowColor = UIColor.blackColor().CGColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowRadius = 2
                
        cell.layer.insertSublayer(shadowLayer, atIndex: 0)
*/
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
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func sendValues(endpnt: NSString, spcie: NSString, viewTyp: NSString){
        print(endpnt)
        endpoint = endpnt as String
        specie = spcie as String
        viewType = viewTyp as String
        myCV.reloadData()
        
    }
    
    func apiCall() {
        /* In order to see what fields are available use, http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmGetItemInfo/Hist/234/json when connected to FLOMwifi */
        
        /* In order to make the search function more useful use, http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmQuery/Hist/cultur^\(endpoint)^any^or!title^\(endpoint)^any^or!descri^\(endpoint)^any^or!langua^\(endpoint)^any^or!subjec^\(endpoint)^any^or!creato^\(endpoint)^any^or/title!descri!covera!date!cultur!image/nosort/1024/0/0/0/0/0/json */
        
        //Default
        var api : NSString = "http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmQuery/Hist/cultur^\(endpoint)^any^or/title!descri!langua!date!cultur!image/dateed/1024/0/0/0/0/0/json"
        
        //Coming from search
        if (viewType == "search"){
            api = "http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmQuery/Hist/cultur^\(endpoint)^any^or!title^\(endpoint)^any^or!descri^\(endpoint)^any^or!langua^\(endpoint)^any^or!subjec^\(endpoint)^any^or!creato^\(endpoint)^any^or/title!descri!langua!date!cultur!image/dateed/1024/0/0/0/0/0/json"
        }
            
        //coming from menu
        else if(viewType == "menu"){
            api = "http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmQuery/Hist/cultur^\(endpoint)^any^or/title!descri!langua!date!cultur!image/dateed/1024/0/0/0/0/0/json"
        }
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
                    self.art = responseDictionary["records"] as? [NSDictionary]
                    // print(self.art)
                    self.myCV.reloadData()
                                                                                
                }
            }
        })
        
        task.resume()
    }
    

}


