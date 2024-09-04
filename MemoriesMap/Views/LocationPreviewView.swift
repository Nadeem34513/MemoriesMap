//
//  LocationPreviewView.swift
//  MemoriesMap
//
//  Created by Nadeem Noushad on 04/09/24.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var isPresenting: Bool = false
    var location: Location
    var body: some View {
        HStack(alignment: .bottom) {
            // image, name and city name
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            // buttons
            VStack(spacing: 8) {
                LearnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
                
        )
        .cornerRadius(10)
    }
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageNames = location.imageNames {
                if let imageName = imageNames.first {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 125, height: 125)
                        .cornerRadius(10)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .overlay {
                            Text("No Preview Image")
                                .font(.caption)
                                .italic()
                        }
                        .frame(width: 125, height: 125)
                        .cornerRadius(10)
                }
            }
        }
        .padding(6)
        .background(Color.white.cornerRadius(10))
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var LearnMoreButton: some View {
        Button(action: {
            vm.sheetLocation = location
        }, label: {
            Text("Learn More")
                .frame(width: 125, height: 35)
        })
        .buttonStyle(BorderedProminentButtonStyle())
    }
    
    private var nextButton: some View {
        Button(action: {
            vm.showNextLocation()
        }, label: {
            Text("Next")
                .frame(width: 125, height: 35)
        })
        .buttonStyle(BorderedButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.green.ignoresSafeArea()
        
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
