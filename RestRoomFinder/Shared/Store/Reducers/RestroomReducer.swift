//
//  RestroomReducer.swift
//  RestRoomFinder
//
//  Created by Nozomu Kuwae on 2022/02/21.
//

import Foundation

func restroomReducer(_ state: RestroomState, _ action: Action) -> RestroomState {
    var state = state
    switch action {
    case let action as SetRestroomsAction:
        state.restrooms = action.restrooms
    default:
        break
    }
    return state
}
