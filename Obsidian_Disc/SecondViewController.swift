//
//  SecondViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/3/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var playerSecretButt: UIButton!
    @IBOutlet weak var announceButt: UIButton!
    @IBOutlet weak var campaignDateButt: UIButton!
    @IBOutlet weak var FancyBoyDaniel: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerSecretButt.layer.borderColor = UIColor(red: 81/255, green: 159/255, blue: 243/255, alpha: 1).cgColor
        announceButt.layer.borderColor = UIColor(red: 81/255, green: 159/255, blue: 243/255, alpha: 1).cgColor
        campaignDateButt.layer.borderColor = UIColor(red: 81/255, green: 159/255, blue: 243/255, alpha: 1).cgColor
        
        playerSecretButt.layer.borderWidth = 2.5
        announceButt.layer.borderWidth = 2.5
        campaignDateButt.layer.borderWidth = 2.5
        
        playerSecretButt.layer.cornerRadius = 10
        announceButt.layer.cornerRadius = 10
        campaignDateButt.layer.cornerRadius = 10

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

