//
//  userCreds.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/24/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import Foundation

struct propertyKey {
    static var userToken: String = ""
    static var userSecret: String = ""
}

class UserCreds: NSData {
    var userToken: String = ""
    var userSecret: String = ""
    
    init?(token: String, secret: String) {
        super.init()
        self.userToken = token
        self.userSecret = secret
        
        if (token == "" || secret == "") {return nil}
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(userToken, forKey: propertyKey.userToken)
        aCoder.encode(userSecret, forKey: propertyKey.userSecret)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let token = aDecoder.decodeObject(forKey: propertyKey.userToken) as? String,
            let secret = aDecoder.decodeObject(forKey: propertyKey.userSecret) as? String else {
                return
        }
        
        self.init(token: token, secret: secret)
    }
    
}
