//
//  HomeView.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/5/24.
//

import Foundation
import SwiftUI
import CoreData

struct HomeView: View{
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var drives : FetchedResults<Drive>
    
    @State var selectedStat : Stat = .topSpeed
    
    var body : some View{
        NavigationView{
            VStack{
                HStack(alignment:.bottom){
                    Text("This Week")
                        .bold()
                        .font(.largeTitle)
                        .padding(0)
                    Spacer()
                    Text(String(drives.count) + " Drives")
                        .padding(0)
                        .font(.headline)
                }
                .padding([.top, .horizontal])
                
                
                let userData : [Value] = [
                    Value(name: "Avg MPH", value: getAvgMph(data:filterData(period: .week))),
                    Value(name: "Top Speed", value: getTopSpeed(data:filterData(period: .week))),
                    Value(name: "Avg Drive Score", value: getAvgDriveScore(data: filterData(period: .week)))
                ]
                
                NavigationLink(destination: TrackDrivesView()){
                    
                    
                    if drives.count == 0{
                        HStack{
                            Text("No Drive Data")
                                .padding(.horizontal)
                            Image(systemName: "chevron.right").padding()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(.black, lineWidth: 1)
                            )
                            .padding([.horizontal, .bottom])
                    }
                    
                    else {
                        HStack{
                            HorizontalBarChartView(data: userData)
                            Image(systemName: "chevron.right").padding()
                            
                        }.overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(.black, lineWidth: 1)
                        )
                        .padding([.horizontal, .bottom])
                    }
                }
                .foregroundColor(.black)
                
                Text("Friends")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                    .font(.largeTitle)
                    .padding(.leading)
                
                Picker("Stat", selection: $selectedStat){
                    Text("AVG Speed").tag(Stat.avgMPH)
                    Text("AVG Score").tag(Stat.avgDriveScore)
                    Text("Top Speed").tag(Stat.topSpeed)
                }
                .pickerStyle(.segmented)
                .padding([.horizontal, .bottom])
                switch selectedStat{
                case .topSpeed : HorizontalBarChartView(data: topSpeedData.sorted { valueA, valueB in
                    valueA.value > valueB.value
                })
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(.black, lineWidth: 1)
                )
                .padding([.horizontal, .bottom])
                case .avgDriveScore : HorizontalBarChartView(data: avgScoreData.sorted { valueA, valueB in
                    valueA.value > valueB.value
                })
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(.black, lineWidth: 1)
                )
                .padding([.horizontal, .bottom])
                default : HorizontalBarChartView(data: avgMphData.sorted { valueA, valueB in
                    valueA.value > valueB.value
                })
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(.black, lineWidth: 1)
                )
                .padding([.horizontal, .bottom])
                }
                NavigationLink(destination: DriveView()){
                    Text("Track Drive")
                        .font(.title2)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    
                }
                .padding(.bottom, 15)
            }
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
        if data.count == 0{
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
