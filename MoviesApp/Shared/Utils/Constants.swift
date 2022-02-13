//
//  Constants.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 10/6/20.
//

import Foundation

struct Constants {
    
    struct ApiKeys {
        static var omdbIdKey: String {
            guard let keyFile = Bundle.main.path(forResource: "Key", ofType: "plist") else {
                return ""
            }
            guard let keys = NSDictionary(contentsOfFile: keyFile) else {
                return ""
            }
            return (keys["apiKey"] as? String) ?? ""
        }
    }
    
    struct Urls {
        static func urlBySearch(search: String) -> String {
            "http://www.omdbapi.com/?s=\(search)&page=1&apikey=\(ApiKeys.omdbIdKey)"
        }
        
        static func urlForMovieDetailsByImdbId(imdbId: String) -> String {
            "http://www.omdbapi.com/?i=\(imdbId)&apikey=\(ApiKeys.omdbIdKey)"
        }
    }
}
