//
//  TwitterViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 3/10/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterViewController: TWTRTimelineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: "FordhamMuseum", APIClient: client)
        self.showTweetActions = true
    }
    
    @IBAction func onComposeButton(sender: AnyObject) {
        // Swift
        let composer = TWTRComposer()
        
        composer.setText("@FordhamMuseum")
        
        // Called from a UIViewController
        composer.showFromViewController(self) {result in
            if (result == TWTRComposerResult.Cancelled) {
                print("Tweet composition cancelled")
            }
            else {
                print("Sending tweet!")
            }
        }
    }
}