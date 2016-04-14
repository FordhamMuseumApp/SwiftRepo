//
//  AudioTableViewCell.swift
//  FordhamMuseum
//
//  Created by Michael Ceraso on 4/13/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit

class AudioTableViewCell: UITableViewCell {

    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
