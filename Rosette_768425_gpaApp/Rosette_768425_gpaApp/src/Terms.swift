//
//  Terms.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import Foundation

class Term {
    public var courses : [Course]
    private var gpa  : Double
    private var grade : String
    
    init(courses: [Course]) {
        self.courses = courses
        self.gpa = 0.0
        self.grade = ""
        
        //self.setgpa()
        //self.setgrade()
    }
    
    public func setgpa() {
        var result : Double = 0.0
        var count : Int = 0
        for idx in self.courses {
            result += idx.getWgp()
            count += idx.getCredit()
        }
        self.gpa = result / Double(count)
    }
    
    public func setgrade() {
        switch self.gpa {
            case 4.0:
                self.grade = "A+"
            case 3.7..<4.0:
                self.grade = "A"
            case 3.5..<3.7:
                self.grade = "A-"
            case 3.2..<3.5:
                self.grade = "B+"
            case 3.0..<3.2:
                self.grade = "B"
            case 2.7..<3.0:
                self.grade = "B-"
            case 2.3..<2.7:
                self.grade = "C+"
            case 2.0..<2.3:
                self.grade = "C"
            case 1.7..<2.0:
                self.grade = "C-"
            case 1.0..<1.7:
                self.grade = "D"
            default:
                self.grade = "F"
        }
    }
    
    public func getgpa() -> Double { return self.gpa }
    public func getgrade() -> String { return self.grade }
    
    
    

    
}

