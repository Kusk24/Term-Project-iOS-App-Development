//
//  ChangePage.swift
//  Term Project
//
//  Created by Win Yu Maung on 17/09/2024.
//

import UIKit

class ChangePage: UIViewController {
    var keyword: String!
    let userDict = UserDefaults.standard.dictionary(forKey: "CurrentUser")
    @IBOutlet weak var Change: UILabel!
    @IBOutlet weak var EnterChange: UILabel!
    @IBOutlet weak var NewKeyword: UITextField!
    @IBOutlet weak var ConfirmedNewKeyword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Change.text = "Change \(keyword ?? "")"
        EnterChange.text = "Please enter new \(keyword ?? "")"
        NewKeyword.placeholder = "New \(keyword ?? "")"
        ConfirmedNewKeyword.placeholder = "Confirm New \(keyword ?? "")"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func ConfirmChangesClicked(_ sender: Any) {
        if keyword.lowercased() == "password" {
            
        } else if keyword.lowercased() == "email" {
            
        } else if keyword.lowercased() == "username" {
            
        }
    }
    
}
