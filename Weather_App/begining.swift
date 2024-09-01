//
//  SwiftUIView.swift
//  Weather_App
//
//  Created by Mohammad Mendahawi on 8/30/24.
//

import SwiftUI
import SwiftData
import CoreLocationUI
import GoogleGenerativeAI

struct SwiftUIView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @EnvironmentObject var locationManager: LocationManager
    @State private var text = ""
    @State private var navigate = false
    var weather: ResponseBody?
    @State private var advise: String?
    private let gemeni = model()
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottomTrailing, endPoint: .topTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if let weather=weather{
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
                    }
                    
                    Text("Time: \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .padding(.bottom, 10)
                    
                    Text("Hello, \(weather?.name ?? "No Data")!")
                        .padding(.top, 10)
                        .font(.system(size: 32, weight: .medium, design: .default))
                        .foregroundColor(.green)
                    
                    Text("My Location")
                        .foregroundColor(.gray)
                    
                    if let weather = weather {
                        let code = weather.weather.first?.icon ?? "02d"
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(code)@2x.png")) { image in
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
                    
                    Text("\(String(format: "%.f", ((weather?.main.temp ?? 273.15) - 273.15).rounded()))°C")
                        .font(.system(size: 40, weight: .medium))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 50) {
                        VStack {
                            Text("H")
                                .font(.system(size: 20))
                            Text("\(String(format: "%.f", ((weather?.main.temp_max ?? 273.15) - 273.15).rounded()))°C")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(.black)
                        }
                        
                        VStack {
                            Text("L")
                                .font(.system(size: 20))
                            Text("\(String(format: "%.f", ((weather?.main.temp_min ?? 273.15) - 273.15).rounded()))°C")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
    private func encoderr(_ weather: ResponseBody) throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(weather)
        return String(data: jsonData, encoding: .utf8) ?? "{}"
    }}

#Preview {
    SwiftUIView(weather: nil)
}
