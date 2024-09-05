//
//  Duration.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/4/24.
//

import Foundation
import SwiftUI

class Duration : ObservableObject{
    
    static var shared = Duration()
    
    @Published var progressTime : Int = 0
    
    
    @Published var hours: Int = 0

    @Published var minutes: Int = 0

    @Published var seconds: Int = 0
    
    
    @Published var timer: Timer?
    
    
    func stopTimer () {
        timer!.invalidate()
        timer = nil
        hours = 0
        minutes = 0
        seconds = 0
    }
    
    func startTimer (){
        guard timer == nil else {
            return
        }
        progressTime = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.progressTime += 1
            self.hours = self.progressTime/3600
            self.minutes = (self.progressTime%3600)/60
            self.seconds = self.progressTime%60
        }
    }
}
