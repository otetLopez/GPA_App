//
//  Course.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import Foundation

class Course {
    private var grade : Double
    
    init (grade : Double) {
        self.grade = grade
    }
    
    func getGrade() -> Double { return self.grade }
}
