//
//  StudentsTableViewController.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController, UISearchResultsUpdating {

    @IBOutlet weak var searchBar: UISearchBar!
    var resultSearchController = UISearchController()
    var filteredTableData = [String]()
    var studentNames = [String]()
    
    var studentList = [Student]()
    var sIdx : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.definesPresentationContext = true
            controller.searchBar.placeholder = "Search Student"
            controller.obscuresBackgroundDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()

            tableView.tableHeaderView = controller.searchBar

            return controller
        })()

        // Reload the table
        tableView.reloadData()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (resultSearchController.isActive) ? filteredTableData.count : studentList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "students", for: indexPath)
        
         if resultSearchController.isActive {
            let cname : String = filteredTableData[indexPath.row]
            cell.textLabel?.text = cname
            
            for student in studentList {
                let name : String = "\(student.getfname()) \(student.getlname())"
                if name == cname {
                    if !student.getcgrade().isEmpty {
                        cell.detailTextLabel?.text = "CGPA:  \(String(format: "%.2f", student.getcgpa()))"
                        break
                    }
                }
            }
         } else {
            let cname : String = studentList[indexPath.row].getfname() + " " + studentList[indexPath.row].getlname()
            cell.textLabel?.text = cname
            
            if studentList[indexPath.row].terms.count > 0 {
                var status : GradeStatus = .STATUS_TERM_GRADE_COMPLETE
                for term in studentList[indexPath.row].terms {
                    if term.getgrade().isEmpty {
                        status = .STATUS_TERM_GRADE_INCOMPLETE
                    }
                }
                
                if status == .STATUS_TERM_GRADE_COMPLETE {
                    studentList[indexPath.row].setcgpa()
                    studentList[indexPath.row].setgrade()
                    
                    cell.detailTextLabel?.text = "CGPA:  \(String(format: "%.2f", studentList[indexPath.row].getcgpa()))"
                }
            }
        }
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        studentNames.removeAll()
        resultSearchController.searchBar.text! = ""
        //resultSearchController.searchBar.setShowsCancelButton(false, animated: true)
        //if studentList.count <= 0 { resultSearchController.searchBar.isHidden = true }
        //else { resultSearchController.searchBar.isHidden = false }
        var idx : Int = 0
        for student in studentList {
            let name : String = "\(student.getfname()) \(student.getlname())"
            studentNames.append(name)
            idx += 1
        }
        tableView.reloadData()
        sIdx = -1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if resultSearchController.isActive {
            //print("DEBUG: You selected student \(filteredTableData[indexPath.row])")
            var idx : Int = 0
            for filtered in studentList {
                let cname : String = "\(filtered.getfname()) \(filtered.getlname())"
                if cname == filteredTableData[indexPath.row] {
                    print("DEBUG: You filter selected student \(studentList[idx].getfname())")
                    sIdx = idx
                    break
                }
                idx += 1
            }
        }
        else {
            print("DEBUG: You selected student \(studentList[indexPath.row].getfname())")
            sIdx = indexPath.row
        }
        resultSearchController.dismiss(animated: false)
        dismiss(animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)

        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (studentNames as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]

        self.tableView.reloadData()
    }
    
    public func addStudent(student : Student) {
        studentList.append(student)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let register = segue.destination as? RegisterViewController {
            register.delegate = self
        }
        
        if let terms = segue.destination as? SemesterTableViewController {
              terms.delegate = self
          }
    }

}
