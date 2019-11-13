//
//  Course.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import Foundation

class Course {
    private var mark : Int
    private var credit : Int
    private var gp : Double
    private var wgp : Double
    private var grade : String
    
    
    init (mark: Int, credit: Int) {
        self.mark = mark
        self.credit = credit
        self.grade = ""
        self.gp = 0.0
        self.wgp = 0.0
        
        /** Get equivalent Grade Point for the given mark **/
        self.setGrade(mark: mark)
        self.wgp = self.gp * Double(credit)
    }
    
    func getMark() -> Int { return self.mark }
    func getCredit() -> Int { return self.credit }
    func getWgp() -> Double { return self.wgp }
    
    
    func setGrade(mark: Int) {
        switch mark {
            case 94...100:
                self.grade = "A+"
                self.gp = 4.0
            case 87...93:
                self.grade = "A"
                self.gp = 3.7
            case 80...86:
                self.grade = "A-"
                self.gp = 3.5
            case 77...79:
                self.grade = "B+"
                self.gp = 3.2
            case 73...76:
                self.grade = "B"
                self.gp = 3.0
            case 70...72:
                self.grade = "B-"
                self.gp = 2.7
            case 67...69:
                self.grade = "C+"
                self.gp = 2.3
            case 63...66:
                self.grade = "C"
                self.gp = 2.0
            case 60...62:
                self.grade = "C-"
                self.gp = 1.7
            case 50...59:
                self.grade = "D"
                self.gp = 1.0
            default:
                self.grade = "F"
                self.gp = 0.0
        }
    }

}
