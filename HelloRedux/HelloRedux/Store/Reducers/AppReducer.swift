//
//  AppReducer.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/02/06.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action) -> AppState {
    var state = state
    state.counterState = counterReducer(state.counterState, action)
    return state
}
