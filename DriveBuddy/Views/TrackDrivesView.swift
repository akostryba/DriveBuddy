//
//  TrackDrivesView.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/5/24.
//

import Foundation
import SwiftUI
import CoreData

struct TrackDrivesView : View{
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var drives : FetchedResults<Drive>
    
    @State var selectedPeriod : Period = .week
    
    var body : some View{
        VStack{
            Text("Track Drives")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .font(.largeTitle)
                .padding([.horizontal])
                .padding(.bottom, 0)
                
            Picker("Period", selection: $selectedPeriod){
                Text("Week").tag(Period.week)
                Text("Month").tag(Period.month)
                Text("Year").tag(Period.year)
            }
            .pickerStyle(.segmented)
            .padding(.top, 0)
            .padding(.horizontal)
            
            
            let userData : [Value] = [
                Value(name: "Avg MPH", value: getAvgMph(data:filterData(period: $selectedPeriod.wrappedValue))),
                Value(name: "Top Speed", value: getTopSpeed(data:filterData(period: $selectedPeriod.wrappedValue))),
                Value(name: "Avg Drive Score", value: getAvgDriveScore(data: filterData(period: $selectedPeriod.wrappedValue)))
            ]
            
            
            if drives.count == 0{
                Text("No Drive Data")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.black, lineWidth: 1)
                    )
                    .padding([.horizontal, .bottom])
            }
            else{
                HorizontalBarChartView(data: userData)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.black, lineWidth: 1)
                    )
                    .padding()
                    .padding(.bottom, 0)
            }
            
            HStack(spacing:10){
                Text("Rapid Acceleration :")
                    .font(.headline)
                Text("\(getTotalRA(data: filterData(period: $selectedPeriod.wrappedValue))) occurrence(s)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal, .bottom])
            
            HStack(spacing:10){
                Text("Sudden Braking :")
                    .font(.headline)
                Text("\(getTotalRDA(data: filterData(period: $selectedPeriod.wrappedValue))) occurrence(s)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, 50)
            Spacer()
        }
    }
    
    func filterData(period: Period? = nil) -> [Drive] {
        let calendar = Calendar(identifier: .iso8601)
        let date = Date()
        switch period{
        case .week :
            do {
                var result : [Drive] = []
                let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
                for drive in drives{
                    if drive.date! >= startOfWeek!{
                        result.append(drive)
                    }
                }
                return result
            }
        case .month :
            do {
                var result : [Drive] = []
                let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))
                for drive in drives{
                    if drive.date! >= startOfMonth!{
                        result.append(drive)
                    }
                }
                return result
            }
        default :
            do {
                var result : [Drive] = []
                let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: date))
                for drive in drives{
                    if drive.date! >= startOfYear!{
                        result.append(drive)
                    }
                }
                return result
            }
        }
    }
    
    func getAvgMph(data : [Drive]) -> Double{
            var sum = 0.0
            for drive in data{
                sum += drive.averageMPH
            }
            return sum/Double(data.count)
    }

    func getAvgDriveScore(data : [Drive]) -> Double{
            var sum = 0.0
            for drive in data{
                sum += Double(drive.score)
            }
            return sum/Double(data.count)
    }

    func getTopSpeed(data : [Drive]) -> Double{
        if data.count==0{
            return 0
        }
        return data.max{
                DriveA, DriveB in
                DriveA.topSpeed < DriveB.topSpeed
            }!.topSpeed
    }

    func getTotalRA(data: [Drive]) -> Int{
        var sum = 0
        for drive in data{
            sum += Int(drive.raCount)
        }
        return sum
    }

    func getTotalRDA(data: [Drive]) -> Int{
        var sum = 0
        for drive in data{
            sum += Int(drive.rdaCount)
        }
        return sum
    }
    
}
