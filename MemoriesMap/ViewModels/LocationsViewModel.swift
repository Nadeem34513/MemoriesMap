//
//  LocationViewModel.swift
//  MemoriesMap
//
//  Created by Nadeem Noushad on 03/09/24.
//

import Foundation
import MapKit
import _MapKit_SwiftUI
import SwiftUI

class LocationsViewModel: ObservableObject {
    // all loaded location
    @Published var locations: [Location]
    
    // current location
    @Published var mapLocation: Location {
        didSet {
            updateMapPosition(location: mapLocation)
        }
    }
    
    // current region on map
    @Published var mapRegion: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    
    // show list of locations
    @Published var showLocationList: Bool = false
    
    var mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapPosition(location: locations.first!)
    }
    
    private func updateMapPosition(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = .region(MKCoordinateRegion(center: location.coordinates, span: mapSpan))
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showSelectedLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
}
