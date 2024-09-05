//
//  HorizontalBarChartView.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/5/24.
//

import Foundation
import Charts
import SwiftUI

struct HorizontalBarChartView: View{
    
    let data: [Value]
    
    var body : some View{
        GeometryReader{ geometry in
            VStack(alignment: .leading) {
                let rowH = geometry.size.height/CGFloat(data.count)
                let labelW = geometry.size.width * 0.15
                let graphW = geometry.size.width * 0.6
                let valueW = geometry.size.width * 0.1
                
                ForEach(data){dataPoint in
                    HStack {
                        Text(dataPoint.name)
                            .font(.caption)
                            .bold()
                            .frame(maxWidth: labelW, maxHeight: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                        
                        
                        let rowW = dataPoint.value / getMax(data: data) * graphW
                        Rectangle()
                            .cornerRadius(5)
                            .padding(.vertical, 5)
                            .frame(maxWidth: rowW, maxHeight: .infinity, alignment: .leading)
                            .foregroundColor(Color.teal)
                        
                        Text(String(format: "%.1f", dataPoint.value))
                            .font(.caption2)
                            .frame(maxWidth: valueW, maxHeight: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: rowH)
                }
            }
            .padding(.vertical)
        }
    }
    
    func getMax(data : [Value]) -> Double{
        return data.max {a, b in a.value < b.value}!.value
    }
}
