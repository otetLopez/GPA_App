//
//  SemesterTableViewController.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit

class SemesterTableViewController: UITableViewController {

    weak var delegate: StudentsTableViewController?
    //var courseList = [Course]()
    var termList = [Term]()
    var isAdded : Bool = false
    var sIdx : Int = -1
    var termIdx : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        sIdx = self.delegate!.sIdx
        if self.delegate?.studentList[sIdx].terms.count == 0 {  createTerms() }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: You selected Term \(indexPath.row + 1)")
        termIdx = indexPath.row
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        termIdx = -1
    }
    
    func createCourses () -> [Course] {
        // Given that all terms have 5 Coures
        var courseList = [Course]()
        for idx in 1...5 {
            let course : Course = Course(credit: idx)
            courseList.append(course)
        }
        return courseList
    }
    
    func createTerms() {
        print("DEBUG: Creating terms")
        for _ in 1...3 {
            let term : Term = Term(courses: createCourses())
            self.delegate?.studentList[sIdx].terms.append(term)
        }
    }
    
//    func addCourse(course: Course) {
//        print("DEBUG: Added course with the following details:\n\(course)")
//        //courseList.append(course)
//        
//    }
//    
//    func addTerm(term: Term) {
//        print("DEBUG: Added term with the following details:\n")
//        termList.append(term)
//    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "term cell", for: indexPath)
        cell.textLabel?.text = "Term \(indexPath.row + 1)"
        // Configure the cell...

        if (!(self.delegate?.studentList[sIdx].terms[indexPath.row].getgrade().isEmpty)!) {
            let gpaLabel : String = "GPA: \(String(format: "%.2f", (self.delegate?.studentList[sIdx].terms[indexPath.row].getgpa())!))"
            cell.detailTextLabel?.text = gpaLabel
        } else { print("DEBUG: Student has no GPA for Term \(indexPath.row + 1)") }
        
        return cell
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
        
        if let course = segue.destination as? CoursesViewController {
            course.delegate = self
        }
    }

}
