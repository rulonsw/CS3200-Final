
//  QueryBuilder.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/24/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//
//  Query manager structure largely "borrowed" from Brad Richardson's presentation dated 1/30/17 on
//  Spotify query building.
//
//import Foundation
//
//class QueryBuilder {
//    
//    static let baseQueryString = "https://api.obsidianportal.com/v1/"
    // , completion: @escaping (_ entries: [sparse_wiki]) -> Void
//    func searchForSparseList(userObj: UserCreds) {
        //Obsidian Portal's wiki "List" API does not allow appended queries.
        // So, no especially useful subtasks for us in this one.
        //HTTP HEADER AUTH
//        let myJustDefaults = JustSessionDefaults(
//            JSONReadingOptions: .mutableContainers, // NSJSONSerialization reading options
//            JSONWritingOptions: .prettyPrinted,     // NSJSONSerialization writing options
//            headers:              [
//                "authorization": "OAuth oauth_consumer_key=\"AkvZ7hmqd59opCfaUd44\",oauth_token=\"WuIsSM2b0cI4w5vXENXY\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"" + (String)((Int)(Date().timeIntervalSince1970.rounded())) + "\",oauth_nonce=\"" + randomString(length: 6) + "\",oauth_version=\"1.0\",oauth_signature=\"%2B4Ek2ULzFtNMH7kVO7Ff1yJzkjU%3D\"",
//                "cache-control": "no-cache"            ],
//            // headers to include in every request
//            credentialPersistence: .none,           // NSURLCredential persistence options
//            encoding: String.Encoding.utf8          // en(de)coding for HTTP body
//        )
//        let just = JustOf<HTTP>(defaults: myJustDefaults)
//        
//        let result = just.get("https://api.obsidianportal.com/v1/users/me.json").response
//
//        let headers = [
//            "authorization": "OAuth oauth_consumer_key=\"AkvZ7hmqd59opCfaUd44\",oauth_token=\"WuIsSM2b0cI4w5vXENXY\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"" + (String)((Int)(Date().timeIntervalSince1970.rounded())) + "\",oauth_nonce=\"" + randomString(length: 6) + "\",oauth_version=\"1.0\",oauth_signature=\"%2B4Ek2ULzFtNMH7kVO7Ff1yJzkjU%3D\"",
//            "cache-control": "no-cache",
//            "postman-token": "15d287e8-9635-d321-0676-e395b55c9ac1"
//        ]
//        
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api.obsidianportal.com/v1/users/me.json")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//        
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
//            }
//        })
//        
//        dataTask.resume()
        
//        print(result)
    
//        guard let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//            let url = URL(string: baseQueryString + escapedQuery) else {
//                return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data,
//                error == nil else {
//                    print("failed to fetch data")
//                    return
//            }
//            
//            //print(NSString(data: data, encoding: String.Encoding.utf8.rawValue))
//            
//            guard let raw = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
//                let json = raw as? [String: AnyObject] else {
//                    print("failed to parse json")
//                    return
//            }
//            
//            let tracks = parseSpotifyTracks(json: json)
//            DispatchQueue.main.async {
//                completion(tracks)
//            }
//        }
//        task.resume()
//    }
//    
//    static func parseSpotifyTracks(json: [String: AnyObject]) -> [SpotifyTrack] {
//        var tracks = [SpotifyTrack]()
//        guard let jsonTracks = json["tracks"] as? [String: AnyObject],
//            let jsonItems = jsonTracks["items"] as? [[String: AnyObject]] else {
//                return tracks
//        }
//        
//        for jsonItem in jsonItems {
//            tracks.append(SpotifyTrack(json: jsonItem))
//        }
//        
//        return tracks
//    }
//    }
//    func randomString(length: Int) -> String {
//        
//        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//        let len = UInt32(letters.length)
//        
//        var randomString = ""
//        
//        for _ in 0 ..< length {
//            let rand = arc4random_uniform(len)
//            var nextChar = letters.character(at: Int(rand))
//            randomString += NSString(characters: &nextChar, length: 1) as String
//        }
//        
//        return randomString
//    }
//}
