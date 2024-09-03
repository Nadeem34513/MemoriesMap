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
    
    // show location details sheet
    @Published var sheetLocation: Location? = nil
    
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
    
    func showNextLocation() {
        // get cuurent index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else { return }
        
        // check if nextIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // show first location if nextIndex does not contain in the locations array
            guard let firstLocation = locations.first else { return }
            showSelectedLocation(location: firstLocation)
            return
        }
        
        // nextIndex is valid
        let location = locations[nextIndex]
        showSelectedLocation(location: location)
    }
}
