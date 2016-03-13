//
//  DetailViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 3/10/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var regionDateLabel: UILabel!
    @IBOutlet weak var materialHeightLabel: UILabel!
    @IBOutlet weak var collectionCollectionNumberLabel: UILabel!
    @IBOutlet weak var museumLabel: UILabel!
    @IBOutlet weak var playButtonImage: UIImageView!
    @IBOutlet weak var pauseButtonImage: UIImageView!
    @IBOutlet weak var skipBackButtonImage: UIImageView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
