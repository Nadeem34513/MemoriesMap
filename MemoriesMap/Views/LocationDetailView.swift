//
//  LocationDetailView.swift
//  MemoriesMap
//
//  Created by Nadeem Noushad on 04/09/24.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    var body: some View {
        ScrollView {
            VStack {
                // image carousel
                imageCarousel
                    .shadow(color: .black.opacity(0.3), radius: 25, y: 20)
                
                // location details
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                        .aspectRatio(1, contentMode: .fill)
                        .allowsHitTesting(false)
                        .cornerRadius(30)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}

extension LocationDetailView {
    private var imageCarousel: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width)
                    .clipped()
            }
        
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(Color.secondary)
        } 
    }
    
    private var descriptionSection: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(Color.blue)
            }
        }
    }
    
    private var mapLayer: some View {
        Map(position: .constant(
            MapCameraPosition.region(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))))) {
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .shadow(radius: 30)
                }
            }
        
//        Map(position: $vm.mapRegion) {
//            ForEach(vm.locations) { location in
//                Annotation(location.name, coordinate: location.coordinates) {
//                    LocationMapAnnotationView()
//                        .shadow(radius: 30)
//                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
//                        .onTapGesture {
//                            vm.showSelectedLocation(location: location)
//                        }
//                }
//            }
//        }
    }
}
