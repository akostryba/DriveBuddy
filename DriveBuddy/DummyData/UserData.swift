//
//  UserData.swift
//  akostryba
//
//  Created by Andrew Kostryba on 6/1/24.
//

import Foundation

struct Value : Identifiable {
    let id = UUID()
    let name : String
    let value : Double
}


let avgMphData : [Value] = [
    Value(name: "Joe", value: 20.1),
    Value(name: "Jake", value: 25.1),
    Value(name: "David", value: 29.3),
    Value(name: "Mike", value: 14.7),
    Value(name: "Harvey", value: 10.9),
    Value(name: "Luis", value: 30.5)
]

let avgScoreData : [Value] = [
    Value(name: "Joe", value: 67),
    Value(name: "Jake", value: 54),
    Value(name: "David", value: 99),
    Value(name: "Mike", value: 65),
    Value(name: "Harvey", value: 89),
    Value(name: "Luis", value: 74)
]

let topSpeedData : [Value] = [
    Value(name: "Joe", value: 99),
    Value(name: "Jake", value: 70),
    Value(name: "David", value: 40),
    Value(name: "Mike", value: 29),
    Value(name: "Harvey", value: 77),
    Value(name: "Luis", value: 64)
]



