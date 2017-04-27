//
//  fullLogViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/6/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit
import RealmSwift

class fullLogViewController: UIViewController, UITextViewDelegate {
    
    //MARK: Adventure Log Realm
    
    //Not sure if I need this on this view controller too, but it doesn't hurt to be safe.
    var adventures = List<Log>()
    var notificationToken: NotificationToken!
    var realm: Realm!
    func setupRealm() {
        let username = "rulonsdangerwoodiv+cs3200@gmail.com"
        let password = "asdfasdf"
        
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://127.0.0.1:9080")!) { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            DispatchQueue.main.async {
                // Open Realm
                let configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://127.0.0.1:9080/~/obs-disc")!)
                )
                self.realm = try! Realm(configuration: configuration)
                
                // Show initial tasks
                func updateList() {
                    if self.adventures.realm == nil, let list = self.realm.objects(LogList.self).first {
                        self.adventures = list.allLogs
                    }
                }
                updateList()
                
                // Notify us when Realm changes
                self.notificationToken = self.realm.addNotificationBlock { _ in
                    updateList()
                }
            }
        }
    }
 
    
    //MARK: Declarations
    //Controlling what elements are visible at any given time
    var state = 0
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if state == 1 {
            self.addLogToRealm()
        }
        self.dismiss(animated: true, completion: {
            //nothing to do here
        })

    }
    
    @IBOutlet var newAdventureTitleField: UITextField!
    @IBOutlet var newAdventureDescField: UITextField!

    @IBOutlet var cancelButt: UIBarButtonItem!
    @IBOutlet weak var doneButt: UIBarButtonItem!
    @IBOutlet weak var fullLogTitle: UILabel!
    @IBOutlet weak var fullLogDesc: UILabel!
    @IBOutlet weak var fullLogBody: UITextView!
    @IBOutlet weak var logNavTitle: UINavigationItem!
    

    
    
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
    
    var adv = Log()
    
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRealm()
        
        //If we're reading...
        if(state == 0) {
            fullLogTitle.text = adv.title
            fullLogDesc.text = adv.desc
            fullLogBody.text = adv.body
            navBarTitle.title = adv.title
            
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
    
    func addLogToRealm() {
        guard let adventureTitle = newAdventureTitleField.text,
            let adventureDesc = newAdventureDescField.text,
            let adventureBody = fullLogBody.text,
            !adventureTitle.isEmpty,
            !adventureBody.isEmpty else { return }
        print("got here")
        let adventures = self.adventures
        try! adventures.realm?.write {
            adventures.append(Log(value: ["title": adventureTitle, "desc":adventureDesc, "date": Date(), "body":adventureBody]))
        }
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
