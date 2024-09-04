//
//  LocationsListView.swift
//  MemoriesMap
//
//  Created by Nadeem Noushad on 03/09/24.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button(action: {
                    vm.showSelectedLocation(location: location)
                }, label: {
                    ListRowView(location: location)
                })
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}

extension LocationsListView {
    private func ListRowView(location: Location) -> some View {
        HStack(spacing: 10) {
            // image
            if let imageNames = location.imageNames {
                if let imageName = imageNames.first {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .cornerRadius(10)
                }
            } else {
                ProgressView()
            }
            
            // name and city
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
