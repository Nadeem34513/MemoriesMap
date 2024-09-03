//
//  MemoriesMapApp.swift
//  MemoriesMap
//
//  Created by Nadeem Noushad on 03/09/24.
//

import SwiftUI

// extending View to include good old cornerRadius modifier
extension View {
    func cornerRadius(_ radius: Double) -> some View {
        clipShape(.rect(cornerRadius: radius))
    }
}

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
