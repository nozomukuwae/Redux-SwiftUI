//
//  Store.swift
//  HelloRedux
//
//  Created by Mohammad Azam on 9/14/20.
//

import Foundation

typealias Dispatcher = (Action) -> Void

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middleware<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) -> Void

protocol ReduxState {}

struct AppState: ReduxState {
    var movies = MoviesState()
}

struct MoviesState: ReduxState {
    var movies = [Movie]()
    var selectedMovieDetail: MovieDetail?
}

protocol Action {}

struct FetchMoviesAction: Action {
    let search: String
}

struct SetMoviesAction: Action {
    let movies: [Movie]
}

struct FetchMovieDetailAction: Action {
    let imdbId: String
}

struct SetMovieDetailAction: Action {
    let detail: MovieDetail
}

class Store<StoreState: ReduxState>: ObservableObject {
    
    var reducer: Reducer<StoreState>
    @Published var state: StoreState
    var middlewares: [Middleware<StoreState>]
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState,
         middlewares: [Middleware<StoreState>] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
        
        // run all middlewares
        middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
    
}
