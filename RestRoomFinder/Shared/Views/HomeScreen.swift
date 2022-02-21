//
//  HomeScreen.swift
//  RestRoomFinder
//
//  Created by Mohammad Azam on 10/14/20.
//

import SwiftUI

struct HomeScreen: View {
    
    var body: some View {
        Text("Hello World")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer, state: AppState())
        return HomeScreen().environmentObject(store)
    }
}
