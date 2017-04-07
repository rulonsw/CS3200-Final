//
//  fullLogViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/6/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit

class fullLogViewController: UIViewController {
    @IBOutlet weak var doneButt: UIBarButtonItem!
    @IBOutlet weak var fullLogTitle: UILabel!
    @IBOutlet weak var fullLogDesc: UILabel!
    @IBOutlet weak var fullLogBody: UITextView!
    @IBOutlet weak var logNavTitle: UINavigationItem!
    
    var adv = [
        "advTitle" : "",
        "advSub" : "",
        "advBody" : "",
        "advDate" : ""
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullLogTitle.text = adv["advTitle"]
        fullLogDesc.text = adv["advSub"]
        fullLogBody.text = adv["advBody"]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
