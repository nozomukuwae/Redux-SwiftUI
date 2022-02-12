//
//  ContentView.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/01/22.
//

import SwiftUI

struct ContentView: View {

    @State private var isPresented: Bool = false
    @EnvironmentObject var store: Store<AppState>

    struct Properties {
        let counter: Int
        let onIncrement: () -> Void
        let onIncrementAsync: () -> Void
        let onDecrement: () -> Void
        let onAdd: (Int) -> Void
    }

    private func map(state: CounterState) -> Properties {
        Properties(
            counter: state.counter, 
            onIncrement: {
                store.dispatch(action: IncrementAction())
            },
            onIncrementAsync: {
                store.dispatch(action: IncrementActionAsync())
            },
            onDecrement: {
                store.dispatch(action: DecrementAction())
            },
            onAdd: {
                store.dispatch(action: AddAction(value: $0))
            }
        )
    }

    var body: some View {
        let properties = map(state: store.state.counterState)

        VStack {
            Spacer()
            Text("\(properties.counter)")
                .padding()
            Button("Increment") {
                properties.onIncrement()
            }
            Button("IncrementAync") {
                properties.onIncrementAsync()
            }
            Button("Decrement") {
                properties.onDecrement()
            }
            Button("Add") {
                properties.onAdd(100)
            }

            Spacer()
            Button("Add Task") {
                isPresented = true

            }

            Spacer()
        }.sheet(isPresented: $isPresented, content: {
            AddTaskView().environmentObject(store)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer, state: AppState())
        return ContentView().environmentObject(store)
    }
}
