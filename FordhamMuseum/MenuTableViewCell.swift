//
//  MenuTableViewCell.swift
//  FordhamMuseum
//
//  Created by Michael Gonzales on 4/5/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var speciesImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
