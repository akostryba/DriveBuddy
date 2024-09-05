//
//  HistoryView.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/5/24.
//

import Foundation
import SwiftUI

struct HistoryView : View{
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var drives : FetchedResults<Drive>
    
    var body : some View{
        NavigationStack{
            VStack{
                List(drives){ drive in
                    NavigationLink(value: drive){
                        DriveRow(drive: drive)
                    }
                }
                .navigationDestination(for : Drive.self){ drive in DriveStatsView(drive: DriveInstance(score: Int(drive.score), distance: drive.distance, averageMPH: drive.averageMPH, topSpeed: drive.topSpeed, raCount: Int(drive.raCount), rdaCount: Int(drive.rdaCount), duration: drive.duration, date: drive.date!))}
            }.navigationTitle("History")
        }
    }
}

struct DriveRow : View{
    var drive: Drive
    
    var body : some View{
        VStack(alignment: .leading)
        {
            Text(drive.date!.formatted(date: .abbreviated, time: .shortened))
            Text("Mileage : " + String(format: "%.1f", drive.distance) + " miles")
            Text("Top Speed : " + String(format: "%.1f", drive.topSpeed) + " mph")
            Text("Avg Speed : " + String(format: "%.1f", drive.averageMPH) + " mph")
            Text("Drive Score : " + drive.score.description)
        }
    }
}
