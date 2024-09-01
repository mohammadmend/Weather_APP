//
//  test.swift
//  Weather_App
//
//  Created by Mohammad Mendahawi on 8/31/24.
//

import SwiftUI

struct SimpleTextFieldView: View {
    @State private var text = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter City, State", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding()
            }
            .navigationTitle("Simple Test")
        }
    }
}

#Preview {
    SimpleTextFieldView()
}
/*
import SwiftUI
import CoreLocation
import CoreLocationUI

struct ContentView: View {
    // Initialize LocationManager
    @StateObject var locationManager = LocationManager()
    @State private var navigateToContentView = false
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?

    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottomTrailing, endPoint: .topTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                if navigateToContentView {
                    if let location = locationManager.location {
                        if let weather = weather {
                            NavigationLink(
                                destination: SwiftUIView(weather:weather),isActive: $navigateToContentView){
                                   EmptyView()
                                    
                                }
                            //SwiftUIView(weather:weather)
                            
                        } else {
                            
                            LoadingView()
                                .task {
                                    do {
                                        weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                    } catch {
                                        print("Error getting weather: \(error)")
                                    }
                                }
                        }
                    } else {
                        if locationManager.loading {
                            LoadingView()
                        } else {
                            Text("Fetching location...")
                        }
                    }
                } else {
                    VStack {
                        Text("Welcome To The \n    Weather app")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .foregroundColor(.green)
                        Text("Please approve location request")
                        
                        LocationButton(.shareCurrentLocation) {
                            locationManager.requestLocation()
                            navigateToContentView = true
                        }
                        .frame(height: 44)
                        .padding()
                    }
                }
            }
        }
    }
}

import SwiftUI
import CoreLocationUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State private var navigateToContentView = false
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottomTrailing, endPoint: .topTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if !navigateToContentView {
                        VStack {
                            Text("Welcome To The \n    Weather app")
                                .font(.system(size: 32, weight: .bold, design: .default))
                                .foregroundColor(.green)
                            Text("Please approve location request")
                            
                            LocationButton(.shareCurrentLocation) {
                                locationManager.requestLocation()
                                navigateToContentView = true
                            }
                            .frame(height: 44)
                            .padding()
                        }
                    }
                    
                    if navigateToContentView {
                        if let location = locationManager.location {
                            if let weather = weather {
                               
                                NavigationLink(
                                    destination: SwiftUIView(weather:weather), isActive: $navigateToContentView
                                ) {
                                    
                                    //EmptyView()
                                }.hidden()
                                                                 
                                SwiftUIView(weather:weather)
                                
                            }
                            else  {
                                
                                LoadingView()
                                    .task {
                                        do {
                                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                        } catch {
                                            print("Error getting weather: \(error)")
                                        }
                                    }
                            }
                        } else {
                            if locationManager.loading {
                                Text("3")
                                LoadingView()
                            } else {
                                Text("Fetching location...")
                            }
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
} */
