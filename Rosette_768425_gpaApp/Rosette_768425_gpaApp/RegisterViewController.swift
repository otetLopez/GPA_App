//
//  RegisterViewController.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    weak var delegate: StudentsTableViewController?
    @IBOutlet weak var fnameFld: UITextField!
    @IBOutlet weak var lnameFld: UITextField!
    @IBOutlet weak var sidFld: UITextField!
    
    //var registryConfirmed : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped() {
        fnameFld.resignFirstResponder()
        lnameFld.resignFirstResponder()
        sidFld.resignFirstResponder()
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if isFilled() {
            alertAddConfirmation()
        }
    }
    
    func createStudent() {
        let student : Student = Student(fname: fnameFld.text!, lname: lnameFld.text!, sid: sidFld.text!)
        self.delegate?.addStudent(student: student)
        alert(title: "New Contact Saved", msg: "\(fnameFld.text!) is now a student.")
        resetVariables()
    }
    
    func isFilled() -> Bool {
        var err_msg : String = ""
        if fnameFld.text!.isEmpty { err_msg.append("First Name ") }
        if lnameFld.text!.isEmpty {
            if !(err_msg.isEmpty) { err_msg.append(", ") }
            err_msg.append("Last Name ")
        }
        if sidFld.text!.isEmpty {
            if !(err_msg.isEmpty) { err_msg.append(", ") }
            err_msg.append("Student ID ")
        }
        
        if !err_msg.isEmpty {
            err_msg.append("field(s) are empty")
            alert(title: "Error", msg : err_msg)
            return false
        }
        return true
    }
    func alertAddConfirmation()  {
        let alertController = UIAlertController(title: "Student", message: "Are you sure?", preferredStyle: .alert)
         
        let cancelAction = UIAlertAction(title: "No Way!", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.orange, forKey: "titleTextColor")
         
        let sureAction = UIAlertAction(title: "Yes, I'm Sure!", style: .destructive) { (action) in
            print("DEBUG: Sure student")
            if self.isSidValid() { self.createStudent() }
            else { self.alert(title: "Error", msg: "ID already exists") }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(sureAction)
             
        self.present(alertController, animated: true, completion: nil)
     }
    
    func alert(title: String, msg : String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
  
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isSidValid() -> Bool {
        let studentList : [Student] = self.delegate?.studentList ?? [Student]()
        for idx in studentList {
            if idx.getsid() == sidFld.text! {
                return false
            }
        }
        return true
    }
    
    func resetVariables() {
        clearFields()
    }
    
    func clearFields() {
        fnameFld.text! = ""
        lnameFld.text! = ""
        sidFld.text! = ""
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
