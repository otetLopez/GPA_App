//
//  CoursesViewController.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit
import AVFoundation

class CoursesViewController: UIViewController {

    var audioplayer: AVAudioPlayer!
    
    weak var delegate: SemesterTableViewController?
    @IBOutlet var cmarks: [UITextField]!
    @IBOutlet var courseLbl: [UILabel]!
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
        updateCourses()
        
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
    
    func updateCourses() {
        credit.removeAll()
        let termcourses : [String] = programmap[termidx]
        var idx : Int = 0
        for c in courseLbl {
            c.text! = termcourses[idx]
            let num : Int = Int(String(termcourses[idx].last!))!
            credit.append(num)
            print("DEBUG: Credit score for \(termcourses[idx]) is \(num)")
            idx += 1
        }
    }
    
    func setCredits() {
        //credit.removeAll()
        let termcourses : [String] = programmap[termidx]
        var idx : Int = 0
        for c in termcourses {
            let num = (c.last)
            print("DEBUG: Credit score for \(c) is \(num)")
            idx += 1
        }
    }
    
    func calculategpa() {
        var idx : Int = 0
        for mark in marks {
            self.delegate?.delegate?.studentList[sIdx].terms[termidx].courses[idx].setMark(mark: mark)
            self.delegate?.delegate?.studentList[sIdx].terms[termidx].courses[idx].setCredit(credit: credit[idx])
            self.delegate?.delegate?.studentList[sIdx].terms[termidx].courses[idx].setGrade()
            self.delegate?.delegate?.studentList[sIdx].terms[termidx].courses[idx].setWGP()
            idx += 1
        }
        self.delegate?.delegate?.studentList[sIdx].terms[termidx].setgpa()
        self.delegate?.delegate?.studentList[sIdx].terms[termidx].setgrade()
        self.gpa = self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgpa() ?? 0.0
        self.grade = self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgrade() ?? ""
        
        if self.gpa >= 2.8 {
           // TODO play sound
            playSound()
        }
        resultLbl.text! = String(format: "%.2f", self.gpa)
    }
    
    func playSound() {
        let soundURL = Bundle.main.url(forResource: "Win", withExtension: "wav")
        audioplayer = try! AVAudioPlayer(contentsOf: soundURL!)
        audioplayer.play()
    }
    
    func retrieveMarks() {
        if (!(self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgrade().isEmpty)!) {
            print("DEBUG: Student has grade of \(self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgrade() ?? "") which was previously calculated")
            var idx : Int = 0
            for c in cmarks {
                let mark : Int = (self.delegate?.delegate?.studentList[sIdx].terms[termidx].courses[idx].getMark())!
                c.text! =  "\(mark)"
                idx += 1
            }
            self.gpa = (self.delegate?.delegate?.studentList[sIdx].terms[termidx].getgpa())!
            resultLbl.text! = String(format: "%.2f", self.gpa)
        } //else { print("DEBUG: This is the first time this student to calculate gpa of this term.") }
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
