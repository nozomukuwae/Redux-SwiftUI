//
//  TaskReducer.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/02/12.
//

import Foundation

func taskReducer(_ state: TaskState, _ action: Action) -> TaskState {
    var state = state

    switch action {
    case let action as AddTaskAction:
        state.tasks.append(action.task)
    default:
        break
    }

    return state
}
