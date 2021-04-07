//
//  WeatherStore.swift
//  Bement
//
//  Created by Runkai Zhang on 8/11/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation

class WeatherStore {
    var uvIndex: Int
    var temperature: Int
    var summary: String
    var icon: String
    
    init(uvIndex: Int?, temperature: Int?, summary: String?, icon: String?) {
        self.uvIndex = uvIndex ?? 0
        self.temperature = temperature ?? 0
        self.summary = summary ?? "Something went wrong..."
        self.icon = icon ?? "xmark.octagon.fill"
    }
}
