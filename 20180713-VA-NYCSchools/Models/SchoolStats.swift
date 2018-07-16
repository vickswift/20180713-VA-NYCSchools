//
//  SchoolStats.swift
//  20180713-VA-NYCSchools
//
//  Created by Victor  Adu on 7/13/18.
//  Copyright © 2018 Filmic. All rights reserved.
//

import Foundation


struct SchoolStats: Codable {
    
    var dbn: String = ""
    var sat_critical_reading_avg_score = ""
    var sat_math_avg_score = ""
    var sat_writing_avg_score = ""
    
    var mathScore: Double { return Double(self.sat_math_avg_score) ?? 0 }
    var readingScore: Double { return Double(self.sat_critical_reading_avg_score) ?? 0 }
    var writingScore: Double { return Double(self.sat_writing_avg_score) ?? 0 }
    
}
