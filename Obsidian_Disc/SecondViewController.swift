//
//  SecondViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/3/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let choices = ["Set a Campaign Date", "Send an Announcement", "Send a Player Secret"]
        
    @IBOutlet weak var choicesAvailable: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellId = "projectSelfCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as? UITableViewCell else {
            print("Something went horribly wrong here.")
            exit(1)
        }

        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "projectSelfCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ChoiceTableViewCell else {
            print("Something went horribly wrong here.")
            exit(1)
        }
        
        let choice = choices[indexPath.row]
        cell.choiceLabel.text = choice
        
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.choicesAvailable.dataSource = self
        self.choicesAvailable.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

