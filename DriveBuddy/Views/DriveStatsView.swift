//
//  DriveStatsView.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/5/24.
//

import Foundation
import SwiftUI

struct DriveStatsView: View {
    
    var drive: DriveInstance
    
    var body : some View{
        VStack{
            ZStack(alignment: .bottom){
                let percentage = Double(drive.score)/100
                Arc(percentage:percentage, endAngle: .degrees(180), clockwise: true)
                    .stroke(.teal, lineWidth: 20)
                    .frame(width: 160, height: 160)
                    .padding(.top, 90)
                
                
                Arc(percentage:1, endAngle: .degrees(180), clockwise: true)
                    .stroke(.teal, lineWidth: 20)
                    .opacity(0.2)
                    .frame(width: 160, height: 160)
                    .padding(.top, 90)
                
                Text("\(drive.score)")
                    .font(.system(size: 100))
                    .bold()
                    .padding(.bottom, 60)
            }
            
            HStack {
                Text("Date : ")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.vertical, 1)
                Text("\(drive.date.formatted(date: .abbreviated, time: .shortened))")
                    .font(.title2)
                    .opacity(0.5)
                    .padding(.vertical, 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                Text("Mileage : ")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.vertical, 1)
                Text("\(String(format: "%.1f", drive.distance)) miles")
                    .font(.title2)
                    .opacity(0.5)
                    .padding(.vertical, 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                Text("Top Speed : ")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.vertical, 1)
                Text("\(String(format: "%.1f", drive.topSpeed)) mph")
                    .font(.title2)
                    .opacity(0.5)
                    .padding(.vertical, 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
                
            HStack{
                Text("Average Speed : ")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.vertical, 1)
                Text("\(String(format: "%.1f", drive.averageMPH)) mph")
                    .font(.title2)
                    .opacity(0.5)
                    .padding(.vertical, 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            HStack{
                Text("Rapid Acceleration : ")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.vertical, 1)
                Text("\(drive.raCount.description) occurrences")
                    .font(.title2)
                    .opacity(0.5)
                    .padding(.vertical, 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            HStack{
                Text("Sudden Braking : ")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.vertical, 1)
                Text("\(drive.rdaCount.description) occurrences")
                    .font(.title2)
                    .opacity(0.5)
                    .padding(.vertical, 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                Text("Duration : ")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.vertical, 1)
                Text("\(String(format: "%.0f", (drive.duration.rounded()))) minutes")
                    .font(.title2)
                    .opacity(0.5)
                    .padding(.vertical, 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        
    }
}
