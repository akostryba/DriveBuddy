//
//  Drive.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/1/24.
//

import Foundation

class DriveInstance {
    
    var score : Int
    var distance : Double
    var averageMPH : Double
    var topSpeed : Double
    var raCount : Int
    var rdaCount : Int
    var duration : Double
    var date : Date
    
    init(score: Int, distance: Double, averageMPH: Double, topSpeed: Double, raCount: Int, rdaCount: Int, duration: Double, date: Date) {
        self.score = score
        self.distance = distance
        self.averageMPH = averageMPH
        self.topSpeed = topSpeed
        self.raCount = raCount
        self.rdaCount = rdaCount
        self.duration = duration
        self.date = date
    }
}
