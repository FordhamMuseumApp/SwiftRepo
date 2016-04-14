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
    @IBOutlet weak var regionDateLabel: UILabel!
    @IBOutlet weak var materialHeightLabel: UILabel!
    @IBOutlet weak var collectionCollectionNumberLabel: UILabel!
    @IBOutlet weak var museumLabel: UILabel!
    
    var piece: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(piece!)
        
        detailName.text = piece!["title"] as? String
        regionDateLabel.text = piece!["date"] as? String
        materialHeightLabel.text = piece!["langua"] as? String
        collectionCollectionNumberLabel.text = piece!["covera"] as? String
        museumLabel.text = piece!["descri"] as? String
        
        if let pointer = piece!["pointer"]{
            let imagePath = "http://libdigcoll2.library.fordham.edu:2012/cgi-bin/getimage.exe?CISOROOT=/Hist&CISOPTR=\(pointer)&DMSCALE=5&DMWIDTH=320&DMHEIGHT=225&DMX=0&DMY=0&DMTEXT=&REC=1&DMTHUMB=1&DMROTATE=0%27"
            let imageUrl: NSURL = NSURL(string: imagePath as String)!
            detailImage.setImageWithURL(imageUrl)
        }
        
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
