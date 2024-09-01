import SwiftUI
import CoreLocationUI
import CoreLocation

struct cc: View {
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
    cc()
}
