//
//  ContentView.swift
//  Shared
//
//  Created by Mohammad Azam on 9/14/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store<AppState>
    @State private var search: String = ""

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

        VStack {
            TextField("Search", text: $search) { _ in
            } onCommit: {
                properties.onSearch(search)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            List(properties.movies, id: \.imdbId) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieCell(movie: movie)
                }
            }.listStyle(PlainListStyle())
        }
        .navigationTitle("Movies")
        .embedInNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer, state: AppState(), middlewares: [moviesMiddleware()])
        return ContentView().environmentObject(store)
    }
}

struct MovieCell: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top) {
            URLImage(url: movie.poster)
                .frame(width: 100, height: 125)
                .cornerRadius(10)
            Text(movie.title)
        }
    }
}
