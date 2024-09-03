//
//  LocationMapAnnotationView.swift
//  MemoriesMap
//
//  Created by Nadeem Noushad on 04/09/24.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    private var accentColor = Color("AccentColor")
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(6)
                .foregroundStyle(Color.white)
                .background(accentColor)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .foregroundStyle(accentColor)
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    LocationMapAnnotationView()
}
