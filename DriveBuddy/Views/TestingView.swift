//
//  TestingView.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/5/24.
//

import Foundation
import SwiftUI

struct Testing : View{
    var locationTracker = LocationTracker.shared
    @ObservedObject var motionTracker = MotionTracker.shared
    @State var isLocTracking = false
    @State var isMotTracking = false
    
    var body : some View {
        VStack{
            HStack{
                Text(String(motionTracker.x)).padding(.trailing, 100)
                if motionTracker.xOpacity==100{
                    Circle().fill(Color.red).opacity($motionTracker.xOpacity.wrappedValue).frame(width: 50, height: 50, alignment: .center)
                }
            }
            HStack{
                Text(String(motionTracker.y)).padding(.trailing, 100)
                if motionTracker.yOpacity==100{
                    Circle().fill(Color.blue).opacity(motionTracker.yOpacity).frame(width: 50, height: 50, alignment: .center)
                }
            }
            HStack(spacing: 100)
                {
                Text(String(motionTracker.z)).padding(.trailing, 100)
                if motionTracker.zOpacity==100{
                    Circle().fill(Color.green).opacity($motionTracker.zOpacity.wrappedValue).frame(width: 50, height: 50, alignment: .center)
                }
            }
            Text(String(motionTracker.threshold))
            Slider(value: $motionTracker.threshold, in: 1...5)
            Toggle("Location Updates", isOn: $isLocTracking).onChange(of: $isLocTracking.wrappedValue){
                if isLocTracking {
                    locationTracker.startUpdating()
                }
                else{
                    locationTracker.stopUpdating()
                }
            }
            Toggle("Motion Updates", isOn: $isMotTracking).onChange(of: $isMotTracking.wrappedValue){
                if isMotTracking {
                    motionTracker.startTracking()
                }
                else{
                    motionTracker.stopTracking()
                }
            }
            Text(String(motionTracker.magnitude))
        }
    }
}
