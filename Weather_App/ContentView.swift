//
//  ContentView.swift
//  Weather_App
//
//  Created by Mohammad Mendahawi on 8/30/24.
//
import SwiftUI

struct ContentView: View {
    @State private var city: String = ""
    @State private var navigateToCityView = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottomTrailing, endPoint: .topTrailing)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TextField("Enter City, State", text: $city)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding()
                        .onSubmit {
                            if !city.isEmpty {
                                navigateToCityView = true
                            }
                        }
                    
                    NavigationLink(
                        destination: City(place: city),
                        isActive: $navigateToCityView
                    ) {
                        EmptyView()
                    }
                    .hidden()
                    .navigationTitle("Please pick City,State")
                }
                
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
