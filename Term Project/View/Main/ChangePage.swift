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
    
    let userViewModel = UserViewModel(keychainService: KeychainService(service: "com.612054.Term-Project"))
    let Username = CurrentUserViewModel.shared.loadCurrentUser().username!
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
        guard let newKeyword = NewKeyword.text, !newKeyword.isEmpty,
              let confirmedNewKeyword = ConfirmedNewKeyword.text, !confirmedNewKeyword.isEmpty else {
            // Show alert if fields are empty
            let alert = UIAlertController(title: "Missing Information", message: "Please enter and confirm the new \(keyword ?? "").", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Check if both fields match
        if newKeyword != confirmedNewKeyword {
            let alert = UIAlertController(title: "Error", message: "\(keyword ?? "") fields do not match.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if keyword.lowercased() == "password" {
            do {
                // Update the password for the given username using ViewModel
                try userViewModel.updateUserPassword(username: Username, newPassword: NewKeyword.text!)
                
                // Debugging: Print to verify the password update
                print("Updated in Keychain: Username - \(Username), New Password - \(NewKeyword.text!)")
                
                // Navigate to login page
            } catch let error {
                print("Failed to update password: \(error.localizedDescription)")
            }
        } else if keyword.lowercased() == "email" {
            do {
                // Update the password for the given username using ViewModel
                try userViewModel.updateUserEmail(username: Username, newEmail: NewKeyword.text!)
                
                // Debugging: Print to verify the password update
                print("Updated in Keychain: Username - \(Username), New Password - \(NewKeyword.text!)")
                
                // Navigate to login page
            } catch let error {
                print("Failed to update password: \(error.localizedDescription)")
            }
        }
    }
}
