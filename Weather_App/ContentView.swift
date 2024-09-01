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
    @State private var showTooltip = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottomTrailing, endPoint: .topTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("By: Mohammad Mendahawi")
                    
                    Button(action: {
                        showTooltip.toggle()
                      
                    }) {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    .overlay(
                        Group{
                            
                            if showTooltip{
                                Text("PM Accelerator is the premier AI learning and development hub, featuring award-winning AI products and mentors from top-tier companies such as Google, Meta, and Apple. We offer a dynamic AI PM Bootcamp, designed to empower the next generation of AI professionals through hands-on experience, mentorship, and real-world projects.").frame(minWidth:370,minHeight: 180).background(.white).offset(y:-150).opacity(0.2)
                            }
                        }
                                            
                    )
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
