//
//  Student.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import Foundation

class Student {
    private var fname : String
    private var lname : String
    private var sid : String
    private var cgpa : Double
    private var cgrade : String
    private var terms : [Term]
    
    init(fname: String, lname: String, sid: String) {
        self.fname = fname
        self.lname = lname
        self.sid = sid
        self.cgpa = 0.0
        self.cgrade = ""
        self.terms = []
    }
    
    public func setcgpa(gpa: Double) { self.cgpa = gpa }
    public func setcgpa() {
        var result : Double = 0
        var count : Int = 0
        for idx in self.terms {
            result += idx.getgpa()
            count += 1
        }
        self.cgpa = result / Double(count)
    }
    public func setgrade() {
        switch self.cgpa {
            case 4.0:
                self.cgrade = "A+"
            case 3.7..<4.0:
                self.cgrade = "A"
            case 3.5..<3.7:
                self.cgrade = "A-"
            case 3.2..<3.5:
                self.cgrade = "B+"
            case 3.0..<3.2:
                self.cgrade = "B"
            case 2.7..<3.0:
                self.cgrade = "B-"
            case 2.3..<2.7:
                self.cgrade = "C+"
            case 2.0..<2.3:
                self.cgrade = "C"
            case 1.7..<2.0:
                self.cgrade = "C-"
            case 1.0..<1.7:
                self.cgrade = "D"
            default:
                self.cgrade = "F"
        }
    }
    public func setterm(term: [Term]) { self.terms = term }
    
    public func getfname() -> String { return self.fname }
    public func getlname() -> String { return self.lname }
    public func getsid() -> String { return self.sid }
    public func getcgpa() -> Double { return self.cgpa }
    public func getcgrade() -> String { return self.cgrade }
}
