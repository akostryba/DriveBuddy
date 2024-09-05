//
//  DriveArc.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/4/24.
//

import Foundation
import SwiftUI

struct Arc : Shape {
    //let startAngle : Angle
    let percentage : Double
    let endAngle : Angle
    let clockwise : Bool
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        
        path.addArc(center: CGPoint(x : rect.midX, y: rect.midY), radius: rect.width, startAngle: fillDegree(percent:percentage), endAngle: endAngle, clockwise: clockwise)
        
        return path
    }
    
    func fillDegree(percent : Double) -> Angle{
        return .degrees(-((1-percent)*180))
    }
}
