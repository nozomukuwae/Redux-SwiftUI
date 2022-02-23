//
//  HomeScreen.swift
//  RestRoomFinder
//
//  Created by Mohammad Azam on 10/14/20.
//

import SwiftUI
import Combine

struct HomeScreen: View {
    @ObservedObject private var locationManager = LocationManager()
    @EnvironmentObject var store: Store<AppState>
    @State private var cancellables: AnyCancellable?

    struct Properties {
        let restrooms: [Restroom]
        let onFetchRestroomsByLatLng: (Double, Double) -> Void
    }

    private func map(state: RestroomState) -> Properties {
        return Properties(restrooms: state.restrooms) { lat, lng in
            store.dispatch(action: FetchRestroomsAction(lat: lat, lng: lng))
        }
    }

    var body: some View {
        let properties = map(state: store.state.restroom)

        Text("Hello World")
            .onAppear {
                self.cancellables = locationManager.$location.sink { location in
                    if let location = location {
                        properties.onFetchRestroomsByLatLng(
                            location.coordinate.latitude,
                            location.coordinate.longitude
                        )
                    }
                }
            }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer, state: AppState(), middlewares: [restroomMiddleware()])
        return HomeScreen().environmentObject(store)
    }
}
