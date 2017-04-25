//
//  OPResponseTypes.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/24/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import Foundation

class sparse_wiki {
    static var wiki_id: String = ""
    static var title: String = ""
    static var time: String = ""
    static var tagline: String = ""
    
    init(JSON: [String:AnyObject]) {
        guard let id = JSON["id"] as? String,
        let title = JSON["name"] as? String,
        let time = JSON["post_time"] as? String
            else { return }
        guard let tagline = JSON["post_tagline"] as? String
            else { let tagline = "No Tagline for This Adventure Log." }
        
        self.wiki_id = id
        self.title = title
        self.time = time
        self.tagline = tagline
        
    }
    
}

class full_wiki {
    static var basics: sparse_wiki
    static var body: String = ""
    
    init(JSON: [String:AnyObject]) {
        self.basics = sparse
        self.body =
    }
}
