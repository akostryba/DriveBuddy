//
//  DriveView.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/5/24.
//

import Foundation
import SwiftUI
import CoreData

struct DriveView : View{
    
    @Environment(\.managedObjectContext) var managedObjContext
    
    var locationTracker = LocationTracker.shared
    @ObservedObject var motionTracker = MotionTracker.shared
    

    @State var startDisabled = false
    @State var endDisabled = true
    @State var navigate = false
    @State var newDrive : DriveInstance? = nil
    @ObservedObject var duration = Duration.shared

    
    var body : some View{
        
        if navigate{
            DriveStatsView(drive: newDrive!).transition(.move(edge: .trailing))
        }
        else{
            VStack{
                ZStack(alignment: .bottom){
                    let percentage = Double(100-motionTracker.subtract)/100
                    Arc(percentage:percentage, endAngle: .degrees(180), clockwise: true)
                        .stroke(.teal, lineWidth: 20)
                        .frame(width: 100, height: 100)
                        .padding(.top, 90)
                    
                    
                    Arc(percentage:1, endAngle: .degrees(180), clockwise: true)
                        .stroke(.teal, lineWidth: 20)
                        .opacity(0.2)
                        .frame(width: 100, height: 100)
                        .padding(.top, 90)
                    
                    Text("\(100-motionTracker.subtract)")
                        .font(.system(size: 60))
                        .bold()
                        .padding(.bottom, 40)
                }
                
                Text("\(duration.hours) : \(formatTime(time: duration.minutes)) : \(formatTime(time: duration.seconds))")
                    .font(.custom("Futura-CondensedMedium", size: 85))
                
                Spacer()
                
                
                HStack{
                    Button("Start"){
                        duration.startTimer()
                        startDisabled = true
                        endDisabled = false
                        locationTracker.startUpdating()
                        motionTracker.startTracking()
                    }
                    .disabled(startDisabled)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(.green))
                    .font(.system(size: 20))
                    .clipShape(Capsule())
                    .padding(.horizontal, 20)
                    
                    
                    Button("End"){
                        endDisabled = true
                        duration.stopTimer()
                        locationTracker.stopUpdating()
                        motionTracker.stopTracking()
                        newDrive = DriveInstance(score: 100-motionTracker.subtract, distance: locationTracker.getDistance(), averageMPH: locationTracker.getAverageMPH(), topSpeed: locationTracker.getTopSpeed(), raCount: motionTracker.getRaCount(), rdaCount: motionTracker.getRdaCount(), duration: Double(duration.progressTime)/60, date: Date())
//                        userDrives.append(newDrive!)
                        DataController().addDrive(score: 100-motionTracker.subtract, distance: locationTracker.getDistance(), averageMPH: locationTracker.getAverageMPH(), topSpeed: locationTracker.getTopSpeed(), raCount: motionTracker.getRaCount(), rdaCount: motionTracker.getRdaCount(), duration: Double(duration.progressTime)/60, context: managedObjContext)
                        
                        motionTracker.resetData()
                        locationTracker.resetData()
                        withAnimation{
                            navigate = true
                        }
                    }
                    .disabled(endDisabled)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(.red))
                    .font(.system(size: 20))
                    .clipShape(Capsule())
                    .padding(.horizontal, 20)
                    
                }
                .padding(.bottom, 50)
                
                
            }
            .alert("Please keep device vertical", isPresented: $motionTracker.showAlert){
                Button("OK", role: .cancel) { }
            }
        }
            
    }
    
    func formatTime (time : Int) -> String{
        if time < 10{
            return "0\(time)"
        }
        else {
            return "\(time)"
        }
    }
}

