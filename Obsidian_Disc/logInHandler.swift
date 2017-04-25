//
//  logInHandler.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/20/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift


class LogInScreen: UIViewController {
    
    var savedUserCreds = UserCreds(token:"", secret:"")
    
    @IBAction func RequestUserDeets(_ sender: UIButton) {
        
        let oauthswift = OAuth1Swift(
            consumerKey:    "AkvZ7hmqd59opCfaUd44",
            consumerSecret: "RnD3hi8G4PjXLZTY2Qf0QJ7MNGirO3i9DLnozBiS",
            requestTokenUrl: "https://www.obsidianportal.com/oauth/request_token",
            authorizeUrl:    "https://www.obsidianportal.com/oauth/authorize",
            accessTokenUrl:  "https://www.obsidianportal.com/oauth/access_token"
        )
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "obs-disc://oauth-cb/obsidian")!,
            success: {
                credential, response, parameters in
                    print(credential.oauthToken)
                    print(credential.oauthTokenSecret)
                    //Save token and secret for later:
                    self.savedUserCreds = UserCreds(token: credential.oauthToken, secret: credential.oauthTokenSecret)
                    print(self.savedUserCreds.userToken)
                    print(self.savedUserCreds.userSecret)
                
                //Success Alert
                let alert = UIAlertController(title: "Success", message: "Connection to Obsidian Portal successful!", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in self.performSegue(withIdentifier: "continueToAdvTable", sender: self) }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
        },
            failure: { error in
                print(error.localizedDescription)
        }
        )

        let handler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        
        handler.presentCompletion = {
            print("Safari Queued up")
        }
        handler.dismissCompletion = {
            print("Safari Peaced Out")
        }
        DispatchQueue.main.async {
            oauthswift.authorizeURLHandler = handler
            
        }

    }

    
    //Action for the button thing:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //If user decides to take a look at an adventure log
        if(segue.identifier == "continueToAdvTable") {
            guard let navToAdvTable = segue.destination as? FirstViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            
            guard savedUserCreds.userToken != "" && savedUserCreds.userSecret != "" else {
                fatalError("User was never fully authenticated.")
            }
            
            navToAdvTable.isAuth = true
            
            saveCredentials()
        }
        
    }

    //Save/load data functions
    private func saveCredentials() {
        let success = NSKeyedArchiver.archiveRootObject(savedUserCreds, toFile: UserCreds.ArchiveURL.path)
        if success {
            print("User creds saved, yo")
            print("saved user creds: Token - ", savedUserCreds.userToken, " Secret - ", savedUserCreds.userSecret)
        } else {
            print("Something terrible has happened to your user data")
        }
    }
}

