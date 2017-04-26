//
//  SecondViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/3/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit
//import Sword

class SecondViewController: UIViewController {
    @IBOutlet weak var botStatusLabel: UILabel!
    @IBOutlet weak var playerSecretButt: UIButton!
    @IBOutlet weak var announceButt: UIButton!
    @IBOutlet weak var campaignDateButt: UIButton!
    @IBOutlet weak var FancyBoyDaniel: UIImageView!
    
    @IBAction func unwindtoChoiceMenu(segue: UIStoryboardSegue) {
        
    }
    @IBAction func selectADateAction(_ sender: Any?) {
        performSegue(withIdentifier: "campaignDateSegue", sender: Int(0))
    }
    @IBAction func selectGMSecretAction(_ sender: Any?) {
        performSegue(withIdentifier: "playerSecretSegue", sender: Int(1))
    }
    @IBAction func selectAddPlayerAction(_ sender: Any) {
        performSegue(withIdentifier: "addContactSegue", sender: Int(2))
    }
    
    
    //Segue stuff
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //If user decides to set a campaign date
        if(segue.identifier == "campaignDateSegue" || segue.identifier == "playerSecretSegue" || segue.identifier == "addContactSegue") {
            guard let navToChoice = segue.destination as? SocialViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            let disButton = sender as! Int
            
            navToChoice.state = disButton

        }

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
}
