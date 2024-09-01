//
//  curr.swift
//  Weather_App
//
//  Created by Mohammad Mendahawi on 9/1/24.
//

import SwiftUI
import CoreLocationUI

struct curr: View {
    @StateObject var locationManager = LocationManager()
    @State private var navigateToFetchWeather = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .foregroundColor(.green)
                Text("Please approve location request")
                
                LocationButton(.shareCurrentLocation) {
                    
                    locationManager.requestLocation()
                    navigateToFetchWeather = true
                }
                .frame(height: 44)
                .padding()
               /* NavigationLink(
                    destination: WeatherFetchingView(locationManager: locationManager),
                    isActive: $navigateToFetchWeather
                ) {
                    EmptyView()
                }
                .hidden()
            */}
        }
    }
}
#Preview {
    curr()
}
