//
//  LocationTracker.swift
//  akostryba
//
//  Created by Andrew Kostryba on 5/30/24.
//

import Foundation
import SwiftUI
import CoreLocation

class LocationTracker : NSObject, ObservableObject, CLLocationManagerDelegate{
    
    static let shared = LocationTracker()
    private let locationManager = CLLocationManager()
    private var speeds : [CLLocationSpeed] = []
    var prevLocation : CLLocation? = nil
    private var distance : Double = 0
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations[locations.count-1]
        
        //get speed
        if location.speed>0{
            speeds.append(location.speed*2.23694)
            print(location.speed*2.23694)
        }
        
        //get distance
        if prevLocation != nil{
            distance+=location.distance(from: prevLocation!)
            prevLocation=location
        }
        else{
            prevLocation=location
        }
    }
    
    func startUpdating(){
        if locationManager.authorizationStatus != .denied && locationManager.authorizationStatus != .restricted{
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopUpdating() {
        locationManager.stopUpdatingLocation()
        let avgMPH = getAverageMPH()
        let topSpeed = getTopSpeed()
        let distance = getDistance()
        print("Average Speed: " + String(format: "%.1f", avgMPH) + " mph")
        print("Top Speed: " + String(format: "%.1f", topSpeed) + " mph")
        print("Distance Traveled: " + String(format: "%.1f", distance) + " miles")
    }
    
    func resetData(){
        speeds = []
        prevLocation = nil
        distance = 0
    }
    
    func getAverageMPH() -> Double{
        if speeds.count==0{
            return 0
        }
        var sum = 0.0
        for speed in speeds {
            sum += speed
        }
        return sum/Double(speeds.count)
    }
    
    func getTopSpeed() -> Double{
        if speeds.count>0{
            return speeds.max() ?? 0
        }
        return 0
    }
    
    func getDistance() -> Double{
        return distance/1609
    }
    
    
}
