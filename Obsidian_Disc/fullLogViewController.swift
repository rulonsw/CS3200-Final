//
//  fullLogViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/6/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit

class fullLogViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var newAdventureTitleField: UITextField!
    @IBOutlet var newAdventureDescField: UITextField!


    @IBOutlet var cancelButt: UIBarButtonItem!
    @IBOutlet weak var doneButt: UIBarButtonItem!
    @IBOutlet weak var fullLogTitle: UILabel!
    @IBOutlet weak var fullLogDesc: UILabel!
    @IBOutlet weak var fullLogBody: UITextView!
    @IBOutlet weak var logNavTitle: UINavigationItem!
    
    //Controlling what elements are visible at any given time
    var state = 0
    
    
    // MARK: Making my own textview placeholder text
    //Since textviews don't have placeholders...
    func textViewDidBeginEditing(_ tv: UITextView) {
        if tv.textColor == UIColor.lightGray {
            tv.text = ""
            tv.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ tv: UITextView) {
        if tv.text.isEmpty {
            tv.text = "Enter Log Here..."
            tv.textColor = UIColor.lightGray
        }
    }
    
    var adv = [
        "advTitle" : "",
        "advSub" : "",
        "advBody" : "",
        "advDate" : "",
        "advAuthor": ""
    ]
    
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //If we're reading...
        if(state == 0) {
            fullLogTitle.text = adv["advTitle"]
            fullLogDesc.text = String("\" ")! + adv["advSub"]! + String("\"\n—")! + adv["advAuthor"]!
            fullLogBody.text = adv["advBody"]
            navBarTitle.title = adv["advDate"]
            
        }
        //If we're writing...
        else if (state == 1){
            //Enable textview placeholder
            fullLogBody.layer.borderWidth = 1
            fullLogBody.layer.cornerRadius = 3
            fullLogBody.layer.borderColor = UIColor.lightGray.cgColor
            
            fullLogBody.delegate = self
            fullLogBody.isEditable = true
            fullLogTitle.isHidden = true
            fullLogDesc.isHidden = true
            newAdventureTitleField.isHidden = false
            newAdventureTitleField.isEnabled = true
            newAdventureDescField.isHidden = false
            newAdventureDescField.isEnabled = true
            
            //Change Button functionality
            doneButt.title = "Save Log"
            cancelButt.isEnabled = true
            
            
        }
        //If we're editing...
        else {
            print("Okay")
        }

        
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
