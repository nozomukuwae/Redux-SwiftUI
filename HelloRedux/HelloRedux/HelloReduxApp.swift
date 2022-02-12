//
//  HelloReduxApp.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/01/22.
//

import SwiftUI

@main
struct HelloReduxApp: App {
    var body: some Scene {
        let store = Store(
            reducer: appReducer,
            state: AppState(),
            middlewares: [logMiddleWare(), incrementMiddleware()]
        )

        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
