//
//  LocationDealer.swift
//  Weather_App
//
//  Created by Mohammad Mendahawi on 8/30/24.
//
import CoreLocation
import Foundation
class LocationManager: NSObject, ObservableObject
, CLLocationManagerDelegate{
    let locationmanager=CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var loading=false
    override init(){
        super.init()
        locationmanager.delegate=self
        //locationmanager.startUpdatingLocation()
    }
    func requestLocation(){
        loading=true
        locationmanager.requestLocation()
        }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        loading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        loading = false
    }
}
