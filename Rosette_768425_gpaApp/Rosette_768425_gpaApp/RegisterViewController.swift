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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if isFilled() {
            alert()
            createStudent()
        }
        
    }
    
    func createStudent() {
        let student : Student = Student(fname: fnameFld.text!, lname: lnameFld.text!, sid: sidFld.text!)
        self.delegate?.addStudent(student: student)
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
            err_msg.append("fields are empty")
            alert(msg : err_msg)
            return false
        }
        return true
    }
    func alert() {
         let alertController = UIAlertController(title: "Student", message: "Are you sure?", preferredStyle: .alert)
         
         let cancelAction = UIAlertAction(title: "No Way!", style: .cancel) { (action) in
         }
         cancelAction.setValue(UIColor.orange, forKey: "titleTextColor")
         
        let addAction = UIAlertAction(title: "Yes, I'm Sure!", style: .default) { (action) in
                
         }
         addAction.setValue(UIColor.red, forKey: "titleTextColor")

         alertController.addAction(cancelAction)
         alertController.addAction(addAction)
             
         self.present(alertController, animated: true, completion: nil)
     }
    
    func alert(msg : String) {
        let alertController = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            //self.cancelledAction()
        }
        cancelAction.setValue(UIColor.orange, forKey: "titleTextColor")
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
               
        }
        deleteAction.setValue(UIColor.red, forKey: "titleTextColor")

        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
            
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
