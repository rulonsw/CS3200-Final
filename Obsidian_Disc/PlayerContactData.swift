//
//  PlayerContactData.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/25/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import Foundation
import RealmSwift

final class ContactList: Object {
    dynamic var text = ""
    dynamic var id = ""
    let contacts = List<Contact>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Contact: Object {
    dynamic var name: String = ""
    dynamic var phonenumber: String = ""
}
