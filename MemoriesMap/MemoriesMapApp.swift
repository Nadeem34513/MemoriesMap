//
//  MemoriesMapApp.swift
//  MemoriesMap
//
//  Created by Nadeem Noushad on 03/09/24.
//

import SwiftUI

@main
struct MemoriesMapApp: App {
    @StateObject private var vm = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
