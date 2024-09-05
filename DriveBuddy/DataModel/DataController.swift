//
//  DataController.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/5/24.
//

import Foundation
import CoreData

class DataController : ObservableObject{
    
    var container : NSPersistentContainer = NSPersistentContainer(name: "DriveModel")
    
    init(){
        container.loadPersistentStores{ desc, error in
            if let error = error{
                print("Failed to load data: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data Saved")
        }
        catch{
            print("Failed to save")
        }
    }
    
    func addDrive(score : Int, distance : Double, averageMPH : Double, topSpeed : Double, raCount : Int, rdaCount : Int, duration: Double, context: NSManagedObjectContext){
        let drive = Drive(context: context)
        drive.score = Int16(score)
        drive.distance = distance
        drive.averageMPH = averageMPH
        drive.topSpeed = topSpeed
        drive.raCount = Int16(raCount)
        drive.rdaCount = Int16(rdaCount)
        drive.duration = duration
        drive.date = Date()
        drive.id = UUID()
        
        save(context: context )
    }
}
