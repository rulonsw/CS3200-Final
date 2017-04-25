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
    
    var isAuth = false
    
    var retrievedUserCreds = UserCreds()
    
    
    let swiftKeychain = KeychainSwift()

    
    //Segue stuff//
    @IBAction func unwindToTable(sender: UIStoryboardSegue) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //If user decides to take a look at an adventure log
        if(segue.identifier == "TheScoop") {
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
            "advBody" : "The party ventured into some woods. We met a gerblin there. Turned out, we didn't immediately murder it. It turned out to be a sorcerer who had been kissed by a witch, now cursed to walk around in a short, stubby, green-skinned prison for the rest of his days. Cool guy.",
            "advDate" : "10/10/16",
            "advAuthor": "B. Bluejeans"
            
        ],
        [
            "advTitle" : "In Memoriam Barry Bluejeans",
            "advSub" : "Poor boy.",
            "advBody" : "Today, we returned to Phandolin with the Phoenix Fire Gauntlet in tow. Turns out, Gundren Rockseeker hates orcs, so he ended up putting it on and absolutely losing his mind when he saw one loose an arrow in his direction. We tried talking him down, but he ended up blowing himself and the rest of the town up in a monstrous fireball. We took refuge in a well and woke up to find the entire city glassed. You win some, you lose some, I suppose. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sit amet ipsum quis ex semper tristique. Donec in nulla tempus, efficitur lorem at, molestie orci. Nunc ut luctus nisl, ut aliquam arcu. Donec tortor elit, ornare eget interdum at, molestie sit amet quam. In accumsan felis vitae cursus tincidunt. Mauris ac tortor quam. In sagittis sapien sit amet eleifend egestas. Phasellus vel porta lorem. Fusce pretium nisi a quam pharetra faucibus. Pellentesque vitae scelerisque erat, at fermentum urna. Mauris justo sapien, vehicula id lobortis sit amet, pretium id leo.            Aliquam pharetra vestibulum sem eget consequat. Proin nisl est, volutpat at dui sit amet, pretium finibus enim. Donec a lobortis neque. Donec eu leo ullamcorper, fringilla odio a, commodo mauris. Donec sed egestas urna. Cras enim sem, sollicitudin eget orci et, posuere condimentum magna. Quisque eu ligula ultricies, faucibus urna non, laoreet augue. Donec porta efficitur ante eu pretium. Etiam lobortis lectus quis nibh consequat tincidunt. Vivamus sed nisl sagittis sapien molestie auctor. Curabitur luctus eros vitae tristique molestie. \n\nNam consequat sagittis elit, ut dictum arcu lobortis ut. Praesent ultrices blandit justo a fermentum. Nulla vitae diam gravida, sagittis magna dapibus, semper elit. Nullam consectetur lacinia sapien, sit amet pretium risus. Morbi dignissim tristique viverra. Donec non purus eu diam pellentesque finibus. Integer aliquet euismod sapien ut vulputate. Mauris egestas dictum malesuada.\n\n            Nam sed fermentum dui, nec porttitor nulla. Aliquam erat volutpat. Quisque sed tellus sit amet erat sodales vehicula. Quisque eu erat orci. Morbi at metus vitae ex pretium faucibus quis eu dolor. Donec et sollicitudin odio. Duis lobortis condimentum mauris vel commodo. Ut volutpat dapibus ultricies. Pellentesque luctus erat ex, ac consequat turpis porta eget. Suspendisse nec convallis massa. Ut ultricies magna non lectus mollis, congue venenatis nulla aliquam. Vivamus ex massa, interdum id aliquam et, fringilla ac enim. Mauris dapibus auctor ligula ac mattis. Donec sollicitudin et sem a laoreet. Nunc cursus sapien id felis dapibus, et aliquet odio elementum.\n\n            Curabitur varius molestie lectus, a blandit nisi tincidunt et. Suspendisse semper porttitor diam, ac sollicitudin lorem aliquam sit amet. Nullam lacus lectus, finibus ut dolor non, feugiat euismod nibh. Duis rutrum ex sit amet consectetur sodales. Nunc pretium sollicitudin urna, non dignissim metus tincidunt a. Ut libero nunc, ultrices a congue sit amet, auctor non neque. Ut at purus sed lorem auctor egestas ac non urna. Morbi nec elit consectetur, dapibus sem vitae, aliquam risus. Vivamus est tortor, cursus quis sem non, vestibulum imperdiet ex. Curabitur nec ipsum ac sem condimentum ultrices. Ut a diam pharetra, vestibulum lectus vitae, hendrerit tortor. Quisque dictum, felis ut eleifend consectetur, diam tortor maximus metus, a venenatis quam est ac tortor. Suspendisse eu quam congue, euismod sapien eu, mollis magna. Integer accumsan, nisi et volutpat sagittis, quam dolor condimentum diam, non varius nulla dui et odio. Curabitur aliquam dignissim ipsum, vel vehicula tellus ultrices mollis. Quisque quam leo, tempor et tortor non, cursus mattis mauris.",
            "advDate" : "10/17/16",
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
        
        guard isAuth else {
            self.performSegue(withIdentifier: "requireLogin", sender: Any?.self)
            return
        }

        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

