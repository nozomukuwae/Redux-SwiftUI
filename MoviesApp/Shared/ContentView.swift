//
//  ContentView.swift
//  Shared
//
//  Created by Mohammad Azam on 9/14/20.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var store: Store<AppState>

    struct Properties {
        let movies: [Movie]
        let onSearch: (String) -> Void
    }

    private func map(state: MoviesState) -> Properties {
        Properties(movies: state.movies) { keyword in
            store.dispatch(action: FetchMoviesAction(search: keyword))
        }
    }

    var body: some View {
        let properties = map(state: store.state.movies)

        return Text("Hello World")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer, state: AppState(), middlewares: [moviesMiddleware()])
        return ContentView().environmentObject(store)
    }
}
