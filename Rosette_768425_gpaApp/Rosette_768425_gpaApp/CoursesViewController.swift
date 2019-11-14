//
//  CoursesViewController.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {

    weak var delegate: SemesterTableViewController?
    @IBOutlet weak var c1: UITextField!
    @IBOutlet weak var c2: UITextField!
    @IBOutlet weak var c3: UITextField!
    @IBOutlet weak var c4: UITextField!
    @IBOutlet weak var c5: UITextField!
    
    @IBOutlet var cmarks: [UITextField]!
    @IBOutlet weak var c1Lbl: UILabel!
    @IBOutlet weak var c2Lbl: UILabel!
    @IBOutlet weak var c3Lbl: UILabel!
    @IBOutlet weak var c4Lbl: UILabel!
    @IBOutlet weak var c5Lbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    

    var courseList = [Course]()
    var termidx : Int = -1
    var sIdx : Int = -1
    var marks = [Int]()
    var credit : [Int] = [1,2,3,4,5]
    var gpa : Double = 0.0
    var grade : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        termidx = self.delegate!.termIdx
        sIdx = self.delegate!.sIdx
        retrieveMarks()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped() {
        for c in cmarks {
            c.resignFirstResponder()
        }
    }

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        var err : ErrorCodes = .SUCCESSFUL
        marks.removeAll()
        for c in cmarks {
            var mark : Int = 0
            if c.text!.isEmpty {
                err = .ERROR_MISSING_FIELDS
                alert(title: "Error", msg: "\(err): Missing fields \(c.text!)")
            }
            else {
                mark = Int(c.text!)!
                if mark > 100 || mark < 0 {
                    marks.removeAll()
                    err = .ERROR_INVALID_MARK
                    alert(title: "Error", msg: "\(err): Invalid mark inputted \(c.text!)")
                    
                }
            }
            marks.append(mark)
        }
        
        if err == .SUCCESSFUL {
            calculategpa()
        } else { marks.removeAll() }
    }
    
    func calculategpa() {
        var idx : Int = 0
        for mark in marks {
            self.delegate?.delegate?.studentList[sIdx].terms[termidx].courses[idx].setMark(mark: mark)
            self.delegate?.delegate?.studentList[sIdx].terms[termidx].courses[idx].setGrade()
            self.delegate?.delegate?.studentList[sIdx].terms[termidx].courses[idx].setWGP()
            idx += 1
        }
        self.delegate?.delegate?.studentList[sIdx].terms[termidx].setgpa()
        self.delegate?.delegate?.studentList[sIdx].terms[termidx].setgrade()
        self.gpa = self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgpa() ?? 0.0
        self.grade = self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgrade() ?? ""
        
        resultLbl.text! = String(format: "%.2f", self.gpa)
    }
    
    func retrieveMarks() {
        print("DEBUG: Student has grade of \(self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgrade() ?? "") which was previously calculated")
        if (!(self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgrade().isEmpty)!) {
            var idx : Int = 0
            for c in cmarks {
                let mark : Int = (self.delegate?.delegate?.studentList[sIdx].terms[termidx].courses[idx].getMark())!
                c.text! =  "\(mark)"
                idx += 1
            }
            self.gpa = (self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgpa())!
            resultLbl.text! = String(format: "%.2f", self.gpa)
            }
    }
    
//    func createCourse() {
//        var idx : Int = 0
//        for mark in marks {
//            let course : Course = Course(mark: mark, credit: credit[idx])
//            idx += 1
//            //self.delegate?.addCourse(course: course)
//            courseList.append(course)
//        }
//    }
//
//    func createTerm() {
//        let term : Term = Term(courses: courseList)
//        self.gpa = term.getgpa()
//        self.grade = term.getgrade()
//        self.delegate?.addTerm(term : term)
//    }
    
    func alert(title: String, msg : String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
          
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertController.addAction(okAction)
    
        self.present(alertController, animated: true, completion: nil)
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
