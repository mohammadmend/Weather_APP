//
//  City.swift
//  Weather_App
//
//  Created by Mohammad Mendahawi on 8/31/24.
//

import SwiftUI
import CoreLocation
import GoogleGenerativeAI

struct City: View {
    @State private var latitude: CLLocationDegrees?
    @State private var longitude: CLLocationDegrees?
    @State private var location: CLLocation?
    var weatherManager = WeatherManager()
    @State private var weather: ResponseBody?
    @State private var advise: String?
    private let gemeni = model()
    var place: String
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottomTrailing, endPoint: .topTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack{
                        Spacer()
                        NavigationLink(destination: cc()) {
                            Text("For current Location")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    if let weather = weather {
                        VStack {
                            Text("Weather for \(place)")
                                .font(.largeTitle)
                                .padding()
                            
                            Text("Temperature: \(String(format: "%.1f", weather.main.temp - 273.15))°C")
                            Text("Description: \(weather.weather.first?.description ?? "No description available")")
                            
                            if let iconCode = weather.weather.first?.icon {
                                let iconUrl = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
                                AsyncImage(url: URL(string: iconUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                } placeholder: {
                                    ProgressView()
                                }
                                .padding()
                            } else {
                                Image(systemName: "cloud.sun.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 180, height: 180)
                                    .foregroundColor(.blue)
                            }
                            if let advise = advise {
                                ScrollView {
                                    Text(advise)
                                        .padding()
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.white.opacity(0.8))
                                        .cornerRadius(8)
                                        .shadow(radius: 5)
                                }
                                .frame(maxHeight: 200) // Set the maximum height of the suggestion box
                                .padding()
                            } else {
                                ProgressView("Creating Advice...")
                                    .task {
                                        do {
                                            let response = try encoderr(weather)
                                            advise = try await gemeni.generateResponse(from: response)
                                        } catch {
                                            print("Error creating response: \(error)")
                                        }
                                    }
                            }
                            
                            Text("Hello, \(weather.name)")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(.green)
                            
                            Text("\(String(format: "%.f", ((weather.main.temp) - 273.15).rounded()))°C")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(.black)
                            
                            HStack(spacing: 50) {
                                VStack {
                                    Text("H")
                                        .font(.system(size: 20))
                                    Text("\(String(format: "%.f", ((weather.main.temp_max) - 273.15).rounded()))°C")
                                        .font(.system(size: 32, weight: .medium))
                                        .foregroundColor(.black)
                                }
                                
                                VStack {
                                    Text("L")
                                        .font(.system(size: 20))
                                    Text("\(String(format: "%.f", ((weather.main.temp_min) - 273.15).rounded()))°C")
                                        .font(.system(size: 32, weight: .medium))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    } else if let lat = latitude, let lon = longitude {
                        LoadingView()
                            .task {
                                do {
                                    weather = try await weatherManager.getCurrentWeather(latitude: lat, longitude: lon)
                                } catch {
                                    print("Error getting weather: \(error)")
                                }
                            }
                    } else {
                        Text("Fetching coordinates for \(place)...")
                        LoadingView()
                    }
                }
                .onAppear {
                    geocodeAddress()
                }
            }
        }
    }
    
    private func geocodeAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(place) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let location = placemarks?.first?.location {
                DispatchQueue.main.async {
                    self.location = location
                    latitude = location.coordinate.latitude
                    longitude = location.coordinate.longitude
                }
            }
        }
    }
    
    private func encoderr(_ weather: ResponseBody) throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(weather)
        return String(data: jsonData, encoding: .utf8) ?? "{}"
    }
}

#Preview {
    City(place: "Anchorage, AK")
}
