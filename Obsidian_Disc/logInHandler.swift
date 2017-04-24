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

class UserCreds: NSObject {
    var userToken: String = ""
    var userSecret: String = ""
    
}

class LogInScreen: UIViewController {
    
    var savedUserCreds = UserCreds()
    
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
            success: { credential, response, parameters in
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                // create success message
                let alert = UIAlertController(title: "Successful Authentication", message: "You've been logged in!", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
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
    @IBOutlet weak var ODUsername: UITextField!
    @IBOutlet weak var ODPassword: UITextField!
    
    @IBAction func endPWEntry(_ sender: Any) {
    }
    @IBAction func endUNEntry(_ sender: Any) {
    }
}
