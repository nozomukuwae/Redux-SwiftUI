//
//  ContentView.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/01/22.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var store: Store

    struct Properties {
        let counter: Int
        let onIncrement: () -> Void
    }

    private func map(state: State) -> Properties {
        Properties(
            counter: state.counter,
            onIncrement: {
                store.dispatch(action: IncrementAction())
            }
        )
    }

    var body: some View {

        let properties = map(state: store.state)

        VStack {
            Text("\(properties.counter)")
                .padding()
            Button("Increment") {
                properties.onIncrement()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: reducer)
        return ContentView().environmentObject(store)
    }
}
