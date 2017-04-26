//
//  PlayerContactData.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/25/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    dynamic var name: String = ""
    dynamic var phonenumber: String = ""
}

class ContactList: Object {
    let contacts: list<Contact>()
}
