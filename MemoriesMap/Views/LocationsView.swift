//
//  LocationsView.swift
//  MemoriesMap
//
//  Created by Nadeem Noushad on 03/09/24.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel

    var body: some View {
        ZStack {
            Map(position: $vm.mapRegion)
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}


extension LocationsView {
    private var header: some View {
        VStack {
            Button(action: {
                vm.toggleLocationList()
            }, label: {
                Text("\(vm.mapLocation.name), \(vm.mapLocation.cityName)")
                    .font(.title2)
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundStyle(Color.primary)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading, content: {
                        Image(systemName: "arrow.down")
                            .padding()
                            .foregroundStyle(Color.primary)
                            .font(.title2)
                            .rotationEffect(Angle(degrees: vm.showLocationList ? -180 : 0))
                    })
            })
                
            
            if vm.showLocationList {
                LocationsListView()
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.5)
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
}
