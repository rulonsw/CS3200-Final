////
////  QueryBuilder.swift
////  Obsidian_Disc
////
////  Created by Rulon Wood on 4/24/17.
////  Copyright © 2017 Utah State University. All rights reserved.
////
////  Query manager structure largely "borrowed" from Brad Richardson's presentation dated 1/30/17 on
////  Spotify query building.
//
//import Foundation
//
//class QueryBuilder {
//    
//    static let baseQueryString = "http://api.obsidianportal.com/v1/"
//    
//    static func search(query: String, completion: @escaping (_ tracks: [SpotifyTrack]) -> Void) {
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
//    
//    
//}
