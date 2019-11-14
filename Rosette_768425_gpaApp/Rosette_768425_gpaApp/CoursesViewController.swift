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
    var marks = [Int]()
    var credit : [Int] = [1,2,3,4,5]
    var gpa : Double = 0.0
    var grade : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        termidx = self.delegate!.termIdx
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped() {
//        c1.resignFirstResponder()
//        c2.resignFirstResponder()
//        c3.resignFirstResponder()
//        c4.resignFirstResponder()
//        c5.resignFirstResponder()
        for c in cmarks {
            c.resignFirstResponder()
        }
    }

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        var err : ErrorCodes = .SUCCESSFUL
        for c in cmarks {
            var mark : Int = 0
            if c.text!.isEmpty { mark = 0 }
            else {
                mark = Int(c.text!)!
                if mark > 100 || mark < 0 {
                    marks.removeAll()
                    alert(title: "Error", msg: "Invalid mark inputted \(c.text!)")
                    err = .ERROR_UKNOWN
                }
            }
            marks.append(mark)
        }
        //createCourse()
        //createTerm()
        if err == .SUCCESSFUL {
            var idx : Int = 0
            for mark in marks {
                print("there are total \(marks.count)")
                self.delegate?.termList[termidx].courses[idx].setMark(mark: mark)
                self.delegate?.termList[termidx].courses[idx].setGrade()
                self.delegate?.termList[termidx].courses[idx].setWGP()
                idx += 1
            }
            self.delegate?.termList[termidx].setgpa()
            self.delegate?.termList[termidx].setgrade()
            self.gpa = self.delegate?.termList[termidx].getgpa() ?? 0.0
            self.grade = self.delegate?.termList[termidx].getgrade() ?? ""
            
            resultLbl.text! = String(format: "%.2f", self.gpa)
        }
    }
    
    func createCourse() {
        var idx : Int = 0
        for mark in marks {
            let course : Course = Course(mark: mark, credit: credit[idx])
            idx += 1
            //self.delegate?.addCourse(course: course)
            courseList.append(course)
        }
    }
    
    func createTerm() {
        let term : Term = Term(courses: courseList)
        self.gpa = term.getgpa()
        self.grade = term.getgrade()
        self.delegate?.addTerm(term : term)
    }
    
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
