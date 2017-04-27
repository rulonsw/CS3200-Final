//
//  AdvLogData.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/25/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//
import Foundation
import RealmSwift

class LogList: Object {
    dynamic var campaignName = ""
    let allLogs = List<Log>()
    
}
class Log: Object {
    dynamic var title = ""
    dynamic var desc = ""
    dynamic var date = Date()
    dynamic var body = ""
    
}


