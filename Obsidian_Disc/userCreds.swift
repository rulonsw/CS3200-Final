//
//  userCreds.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/24/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import Foundation

class UserCreds: NSObject, NSCoding {
     var userToken: String = ""
     var userSecret: String = ""
    
    init(token: String, secret: String) {
        self.userToken = token
        self.userSecret = secret
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userToken, forKey: "tok")
        aCoder.encode(userSecret, forKey: "sec")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let savtoken = aDecoder.decodeObject(forKey: "tok") as! String
        let savsecret = aDecoder.decodeObject(forKey: "sec") as! String
        
        self.init(token: savtoken, secret: savsecret)
    }
    
    //This is where we archive data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tok_data")
    
}
