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
    
    init(fname: String, lname: String, sid: String) {
        self.fname = fname
        self.lname = lname
        self.sid = sid
    }
    public func getfname() -> String { return self.fname }
    public func getlname() -> String { return self.lname }
    public func getsid() -> String { return self.sid }
}
