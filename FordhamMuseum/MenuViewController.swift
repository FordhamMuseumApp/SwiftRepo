//
//  MenuViewController.swift
//  FordhamMuseum
//
//  Created by Michael Gonzales on 4/5/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    func sendValue (value : NSString)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var delegate: MenuViewControllerDelegate!
    let species = ["Greek", "Etruscan", "Roman", "Mosaic"]
    let endpoints = ["greek", "etruscan", "roman", "mosaic"]
    let images = ["greek", "etruscan", "roman", "mosaic"]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRectZero) // limit the tableview lines

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return species.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuTableViewCell
        cell.selectionStyle = .None
        let title = species[indexPath.item] as! String
        cell.speciesLabel.text = title
       // print(title)
        cell.speciesImage.image = UIImage(named: images[indexPath.item] as! String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("tapped")
        self.delegate?.sendValue(endpoints[indexPath.item])
        print(species[indexPath.item])
        dismissViewControllerAnimated(true, completion: {})
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let specie = species[indexPath!.row]
        let collectionViewController = segue.destinationViewController as! CollectionViewController
       // collectionViewController.endpoint = specie
        
    }
    */

}
