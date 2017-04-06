//
//  AdventureLog.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/3/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit

class AdventureLog: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var logTitle: UILabel!
    @IBOutlet weak var logDesc: UILabel!
    @IBOutlet weak var posterPortrait: UIImageView!
    @IBOutlet weak var logDate: UILabel!
    @IBOutlet weak var logBody: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
