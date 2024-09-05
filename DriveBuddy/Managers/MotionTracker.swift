//
//  MotionTracker.swift
//  akostryba
//
//  Created by Andrew Kostryba on 5/30/24.
//

import Foundation
import SwiftUI
import CoreMotion
import AudioToolbox

class MotionTracker : NSObject, ObservableObject{
    
    static let shared = MotionTracker()
    private let motionManager = CMMotionManager()
    private var timer : Timer?
    private var raCount : Int = 0
    private var rdaCount : Int = 0
    
    @Published var magnitude : Double = 0
    @Published var threshold : Double = 0.5
    @Published var subtract : Int = 0
    
    @Published var x : Double = 0
    @Published var y : Double = 0
    @Published var z : Double = 0
    @Published var pitch : Double = 0
    @Published var showAlert : Bool = false
    
    @Published var xOpacity : Double = 1.0
    @Published var yOpacity : Double = 1.0
    @Published var zOpacity : Double = 1.0
    
    override init(){
        super.init()
    }
    
    func startTracking(){
        motionManager.startAccelerometerUpdates()
        
        motionManager.accelerometerUpdateInterval = 0.1
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main){ (data, error) in
            if let data = data{
                self.pitch = data.attitude.pitch
            }
        }
    
        motionManager.startAccelerometerUpdates(to: OperationQueue.main){ (data, error) in
            if let data = data{
                self.x = data.acceleration.x
                self.y = data.acceleration.y
                self.z = data.acceleration.z
                self.magnitude = sqrt(self.x*self.x + self.y*self.y + self.z*self.z)
                //print(magnitude)
//                if self.magnitude > self.threshold{
//                    print("Magnitude threshold exceeded")
//                    self.raCount += 1
//                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
//                }
                
                
                if self.pitch>1.1{
                    //print(self.z)
                    if self.z>0{
                        if self.z>self.threshold{ //rapid acceleration
                            self.subtract += 3
                            self.raCount += 1
                        }
                    }
                    else{
                        if (-1 * self.z)>self.threshold{ //sudden brake
                            self.subtract += 2
                            self.rdaCount += 1
                        }
                    }
                }
                else{
                    self.showAlert = true
                }
                
            }
        }
    }
    
    func stopTracking(){
        motionManager.stopAccelerometerUpdates()
        motionManager.stopDeviceMotionUpdates()
    }
    
    func resetData(){
        raCount = 0
        rdaCount = 0
        subtract = 0
    }
    
    func getRaCount() -> Int{
        return raCount
    }
    
    func getRdaCount() -> Int{
        return rdaCount
    }
}
