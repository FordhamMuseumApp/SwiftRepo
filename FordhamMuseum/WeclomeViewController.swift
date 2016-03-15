//
//  WeclomeViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 3/10/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit

class WeclomeViewController: UIViewController {

    @IBOutlet weak var arrow: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        upSwipe.direction = .Up
        view.addGestureRecognizer(upSwipe)
      //  arrow.alpha = 0
        
        
        
        print("We linked the storyboard and xcode")

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let i = true
        /*while i{
            UIView.animateWithDuration(1.5, delay: 2.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.arrow.alpha = 1.0
                }, completion: { (Bool) -> Void in
                        print("fadeout")
                })
            UIView.animateWithDuration(1.5, delay: 2.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.arrow.alpha = 0
                }, completion: { (Bool) -> Void in
                    print("fadeout")
            })
            
        }*/
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Up) {
            print("Swipe up")
            performSegueWithIdentifier("open", sender: sender)
        }
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
