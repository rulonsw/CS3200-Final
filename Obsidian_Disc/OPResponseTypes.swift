////
////  OPResponseTypes.swift
////  Obsidian_Disc
////
////  Created by Rulon Wood on 4/24/17.
////  Copyright © 2017 Utah State University. All rights reserved.
////
//
//import Foundation
//
//class sparse_wiki {
//    var wiki_id: String = ""
//    var title: String = ""
//    var time: String = ""
//    var tagline: String = ""
//    init() {
//        wiki_id = ""
//        title = ""
//        time = ""
//        tagline = ""
//    }
//    init(JSON: [String:AnyObject]) {
//        guard let jId = JSON["id"] as? String,
//        let jTitle = JSON["name"] as? String,
//        let jTime = JSON["created_at"] as? String
//            else { return }
//        guard let jTagline = JSON["post_tagline"] as? String
//            else { let jTagline = "No Tagline for This Adventure Log."
//                return}
//        
//        wiki_id = jId
//        title = jTitle
//        time = jTime
//        tagline = jTagline
//        
//    }
//    
//}
//
//class full_wiki {
//    var basics = sparse_wiki()
//    var body: String = ""
//    
//    init(JSON: [String:AnyObject]) {
//        self.basics = sparse_wiki(JSON:JSON)
//        guard let body = JSON["body"] as? String
//            else {
//                return
//        }
//        
//        self.body = body
//        
//    }
//}
