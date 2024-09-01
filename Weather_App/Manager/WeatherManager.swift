//
//  WeatherManager.swift
//  Weather_App
//
//  Created by Mohammad Mendahawi on 8/30/24.
//
import Foundation
import CoreLocation
class WeatherManager{
private let apiKey = "0b60d5c3ce444506f2b8b2ec1703800a"
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)") else {
            fatalError("Missing URL")
        }

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        return decodedData
    }
}
struct ResponseBody: Codable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
struct CoordinatesResponse: Codable {
        var lon: Double
        var lat: Double
    }
struct WeatherResponse: Codable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
struct MainResponse: Codable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
struct WindResponse: Codable {
        var speed: Double
        var deg: Double
    }
}
extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
