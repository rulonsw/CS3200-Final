//
//  ChoiceTableViewCell.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/7/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit

class ChoiceTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var choiceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
