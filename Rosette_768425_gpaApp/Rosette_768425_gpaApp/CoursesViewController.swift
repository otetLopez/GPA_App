//
//  CoursesViewController.swift
//  Rosette_768425_gpaApp
//
//  Created by otet_tud on 11/13/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {

    @IBOutlet weak var c1: UITextField!
    @IBOutlet weak var c2: UITextField!
    @IBOutlet weak var c3: UITextField!
    @IBOutlet weak var c4: UITextField!
    @IBOutlet weak var c5: UITextField!
    
    @IBOutlet weak var c1Lbl: UILabel!
    @IBOutlet weak var c2Lbl: UILabel!
    @IBOutlet weak var c3Lbl: UILabel!
    @IBOutlet weak var c4Lbl: UILabel!
    @IBOutlet weak var c5Lbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped() {
        c1.resignFirstResponder()
        c2.resignFirstResponder()
        c3.resignFirstResponder()
        c4.resignFirstResponder()
        c5.resignFirstResponder()
    }

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
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
