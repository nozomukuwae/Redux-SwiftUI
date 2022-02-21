//
//  Actions.swift
//  RestRoomFinder
//
//  Created by Mohammad Azam on 10/15/20.
//

import Foundation

protocol Action { }

struct FetchRestroomsAction: Action {
    let lat: Double
    let lng: Double
}

struct SetRestroomsAction: Action {
    let restrooms: [Restroom]
}
