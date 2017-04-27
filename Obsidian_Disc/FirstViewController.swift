//
//  FirstViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/3/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
                    self.advTable.reloadData()
                }
                updateList()
                
                // Notify us when Realm changes
                self.notificationToken = self.realm.addNotificationBlock { _ in
                    updateList()
                }
            }
        }
    }
    deinit {
        notificationToken.stop()
    }

    @IBOutlet weak var adventureSearch: UISearchBar!
    @IBOutlet weak var advTable: UITableView!
    
    @IBOutlet var addLogButt: UIBarButtonItem!
    @IBAction func selectAddLog(_ sender: Any) {
        performSegue(withIdentifier: "addNewLogSegue", sender: Int(1))
    }

    var selectedTitle = ""
    var selectedDesc = ""
    var selectedBody = ""
    var selectedAuthor = UIImage()
    var selectedDate = ""
    
    var isAuth = true
    
    let formatter = DateFormatter()

    
    //Segue stuff//
    @IBAction func unwindToTable(sender: UIStoryboardSegue) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //If user decides to take a look at an adventure log
        if(segue.identifier == "TheScoop" || segue.identifier == "addNewLogSegue") {
            guard let navToFullLog = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            // Define the target we're aiming for
            var fullLog = navToFullLog.viewControllers.first as! fullLogViewController

            if segue.identifier == "TheScoop" {
                guard let adventureCell = sender as? AdventureLog else {
                    fatalError("Unexpected sender: \(sender)")
                }
                
                guard let indexPath = advTable.indexPathForSelectedRow else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                let selectedLog = adventures[indexPath.row]
                fullLog.adv = selectedLog
                
            }
            else {
                let adventureAdd = sender as! Int

                fullLog.state = adventureAdd
                
            }

            

        }

        
    }

    //MARK: TableView Stuff
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adventures.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellId = "logCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as! AdventureLog
        
        print("Table cell \(indexPath.row) selected for sending")
        formatter.dateFormat = "MM/dd/yy"
        
        var selectedAdventure = adventures[indexPath.row]
        selectedTitle = selectedAdventure.title
        print(selectedTitle)
        selectedDesc = selectedAdventure.desc
        selectedBody = selectedAdventure.body
        selectedDate = formatter.string(from: selectedAdventure.date)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "logCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AdventureLog else {
            print("Something went horribly wrong here.")
            exit(1)
        }
        let adventureArray = adventures.sorted(byKeyPath: "date", ascending: true)
        let adv = adventureArray[indexPath.row]
        formatter.dateFormat = "MM/dd/yy"

        let date = formatter.string(from: adv.date)
        
        cell.logTitle.text = adv.title
        cell.logDesc.text = adv.desc
        cell.logDate.text = date
        cell.logBody.text = adv.body
        cell.posterPortrait.image = UIImage(named:"BarryBluejeans.jpg")
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRealm()
        self.advTable.dataSource = self
        self.advTable.delegate = self
        
//        if let retrievedUserCreds = loadUserCredsIfAny() {
////            print("This is what loadUserCreds is returning: ", retrievedUserCreds)
////            print("The token of the loaded user is ", retrievedUserCreds.userToken)
//            isAuth = true
//        }
//        else {
//            isAuth = false
//        }
//        
//        if isAuth {//nothing to do here
//        print("User information is stored.")}
//        else {
//            self.performSegue(withIdentifier: "requireLogin", sender: Any?.self)
//        }
//        let retrievedUserCreds = loadUserCredsIfAny()
        
//        qb.searchForSparseList(userObj: retrievedUserCreds!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    private func loadUserCredsIfAny() -> UserCreds? {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: UserCreds.ArchiveURL.path) as? UserCreds
//    }
    
}

