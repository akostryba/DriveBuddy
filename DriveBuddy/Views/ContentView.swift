//
//  ContentView.swift
//  akostryba
//
//  Created by Andrew Kostryba on 5/30/24.
//

import SwiftUI
import CoreData
import Charts

struct ContentView: View {
    
    
    @State var selectedScreen : Int = 1
    
    var body : some View {
        TabView(selection: $selectedScreen){
            HomeView().tabItem {
                Text("Home")
                Image(systemName: "house.fill")
            }.tag(1)
            HistoryView().tabItem {
                Text("History")
                Image(systemName:
                        "book")
            }.tag(2)
        }
        
    }
}


    
#Preview {
    ContentView()
}
