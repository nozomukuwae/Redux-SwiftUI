//
//  CounterReducer.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/02/06.
//

import Foundation

func counterReducer(_ state: CounterState, _ action: Action) -> CounterState {
    var state = state

    switch action {
    case _ as IncrementAction:
        state.counter += 1
    case _ as DecrementAction:
        state.counter -= 1
    case let addAction as AddAction:
        state.counter += addAction.value
    default:
        break
    }

    return state
}
