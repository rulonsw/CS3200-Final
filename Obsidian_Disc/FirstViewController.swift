//
//  FirstViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/3/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var adventureSearch: UISearchBar!
    @IBOutlet weak var searchByLabel: UILabel!
    @IBOutlet weak var sortRelevant: UIButton!
    @IBOutlet weak var sortRecent: UIButton!
    @IBOutlet weak var advTable: UITableView!
    

    var selectedTitle = ""
    var selectedDesc = ""
    var selectedBody = ""
    var selectedAuthor = UIImage()
    var selectedDate = ""

    
    //Segue stuff//
    @IBAction func unwindToTable(sender: UIStoryboardSegue) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print("Did anything happen?")
        if(segue.identifier == "TheScoop") {
            print("Here we go, bois")
            guard let navToFullLog = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
        
            guard let adventureCell = sender as? AdventureLog else {
                fatalError("Unexpected sender: \(sender)")
            }
        
            guard let indexPath = advTable.indexPathForSelectedRow else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedLog = adventureArray[indexPath.row]
            let fullLog = navToFullLog.viewControllers.first as! fullLogViewController
            fullLog.adv = selectedLog
        }
        
    }
    ///////////////

    //This is how I remind this controller/of what it really is
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adventureArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellId = "logCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as? AdventureLog else {
            print("Something went horribly wrong here.")
            exit(1)
        }
        print("Table cell \(indexPath.row) selected for sending")
        var selectedAdventure = adventureArray[indexPath.row]
        selectedTitle = selectedAdventure["advTitle"]!
        print(selectedTitle)
        selectedDesc = selectedAdventure["advSub"]!
        selectedBody = selectedAdventure["advBody"]!
        selectedDate = selectedAdventure["advDate"]!
        
    }
    
    let adventureArray = [
        [
            "advTitle" : "The Very Cool Thing That Happened",
            "advSub" : "Believe me, it was very cool.",
            "advBody" : "The party ventured into some woods. We met a kobold there. Turned out, we didn't immediately murder it. It turned out to be a sorcerer trapped in a kobold's body. Funny - sometimes, people are a little more than what they seem on the outside.",
            "advDate" : "10/10/16",
            "advAuthor": "B. Bluejeans"
            
        ],
        [
            "advTitle" : "In Memoriam Barry Bluejeans",
            "advSub" : "Poor boy.",
            "advBody" : "Today, we returned to Phandolin with the Phoenix Fire Gauntlet in tow. Turns out, Gundren Rockseeker hates orcs, so he ended up putting it on and absolutely losing his mind when he saw one loose an arrow in his direction. We tried talking him down, but he ended up blowing himself and the rest of the town up in a monstrous fireball. We took refuge in a well and woke up to find the entire city glassed. You win some, you lose some, I suppose.",
            "advDate" : "10/17/17",
            "advAuthor" : "B. Bluejeans"
        ],
        [
            "advTitle" : "Three Guys Ride a Train",
            "advSub" : "All Aboard!",
            "advBody" : "On our way up to Neverwinter. Wonder what's going on up there?",
            "advDate" : "10/24/16",
            "advAuthor" : "B. Bluejeans"
        ]
        
    ]

    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "logCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AdventureLog else {
            print("Something went horribly wrong here.")
            exit(1)
        }
        
        let adv = adventureArray[indexPath.row]
        
        cell.logTitle.text = adv["advTitle"]
        cell.logDesc.text = adv["advSub"]
        cell.logDate.text = adv["advDate"]
        cell.logBody.text = adv["advBody"]
        cell.posterPortrait.image = UIImage(named:"BarryBluejeans.jpg")
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.advTable.dataSource = self
        self.advTable.delegate = self
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

