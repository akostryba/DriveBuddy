//
//  User.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/1/24.
//

import Foundation

class User : Identifiable{
    
    var name : String
    let driveCount : Int
    let avgMPH : Double
    let topSpeed : Double
    let avgDriveScore : Double
    let value : Double
    
    init(name: String, driveCount: Int, avgMPH: Double, topSpeed: Double, avgDriveScore: Double) {
        self.name = name
        self.driveCount = driveCount
        self.avgMPH = avgMPH
        self.topSpeed = topSpeed
        self.avgDriveScore = avgDriveScore
        self.value = 5
    }
    
}
