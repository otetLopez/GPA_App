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
    private var terms : [Term]
    
    init(fname: String, lname: String, sid: String) {
        self.fname = fname
        self.lname = lname
        self.sid = sid
        self.cgpa = 0.0
        self.terms = []
    }
    
    public func calculatecgpa() -> Double {
        var result : Double = 0
        var count : Int = 0
        for idx in self.terms {
            result += idx.getgpa()
            count += 1
        }
        return (result / Double(count))
    }
    
    
    public func setcgpa(gpa: Double) { self.cgpa = gpa }
    public func setterm(term: [Term]) { self.terms = term }
    
    public func getfname() -> String { return self.fname }
    public func getlname() -> String { return self.lname }
    public func getsid() -> String { return self.sid }
    public func getcgpa() -> Double { return self.cgpa }
}
