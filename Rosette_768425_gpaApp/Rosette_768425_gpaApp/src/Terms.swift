//
//  Terms.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import Foundation

class Term {
    private var courses : [Course]
    private var gpa  : Double
    
    init(courses: [Course]) {
        self.courses = courses
        self.gpa = 0.0
    }
    
    public func setgpa(gpa: Double) { self.gpa = gpa }
    public func getgpa() -> Double { return self.gpa }
    

    
}

