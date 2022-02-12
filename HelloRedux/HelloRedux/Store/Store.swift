//
//  Store.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/01/22.
//

import Foundation

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State

protocol ReduxState {}

struct AppState: ReduxState {
    var counterState = CounterState()
    var taskState = TaskState()
}

struct TaskState: ReduxState {
    var tasks: [Task] = []
}

struct CounterState: ReduxState {
    var counter: Int = 0
}

protocol Action {}

struct IncrementAction: Action {}
struct DecrementAction: Action {}
struct AddAction: Action {
    let value: Int
}

struct AddTaskAction: Action {
    let task: Task
}

class Store<StoreState: ReduxState>: ObservableObject {
    var reducer: Reducer<StoreState>
    @Published var state: StoreState

    init(reducer: @escaping Reducer<StoreState>, state: StoreState) {
        self.reducer = reducer
        self.state = state
    }

    func dispatch(action: Action) {
        state = reducer(state, action)
    }
}
