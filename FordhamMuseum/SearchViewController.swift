//
//  SearchViewController.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 4/12/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate {
    func sendValues (endpnt : NSString, spcie : NSString)
}

class SearchViewController: UIViewController, UISearchBarDelegate {

    var delegate: SearchViewControllerDelegate!
    var specie = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var previousLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previousLabel.text = "You previously searched: \(specie)"
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonPress(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let term = searchBar.text
        print(term)
        self.delegate?.sendValues(term!, spcie: term!)
        // print(species[indexPath.item])
        dismissViewControllerAnimated(true, completion: {})
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
