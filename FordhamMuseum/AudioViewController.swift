//
//  AudioViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 4/13/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var audioTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Use this: "http://libdigcoll2.library.fordham.edu:2012/dmwebservices/index.php?q=dmQuery/Hist/audioa^,^any^or/title!audio!audioa!date!cultur!image/nosort/1024/0/0/0/0/0/json" to return a dictionary of objects with audio files*/
        
        audioTableView.dataSource = self
        audioTableView.delegate = self
        
        audioTableView.tableFooterView = UIView(frame: CGRectZero) // limits excess tableview cells
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 22
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("audioCell", forIndexPath: indexPath) as! AudioTableViewCell
        // cell.selectionStyle = .None
        let title = "Kylix (drinking cup with stem)"
        let speaker = "Emma Cleary"
        cell.titleLabel.text = title
        cell.speakerLabel.text = speaker
        // print(title)
        
        return cell
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
