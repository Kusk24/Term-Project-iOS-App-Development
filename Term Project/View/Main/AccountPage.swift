//
//  AccountPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit
import LocalAuthentication

class AccountPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableCell") as! AccountTableCell
        let i = indexPath.row
        if i == 0{
            cell.textLabel?.text = "Change Password"
        } else if i == 1{
            cell.textLabel?.text = "Change Email"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        if i == 0{
            authenticate(MyString: "Password")
        } else if i == 1 {
            authenticate(MyString: "Email")
        }
    }

    @IBOutlet weak var AccountTable: UITableView!
    @IBOutlet weak var UserName: UILabel!
    let userDict = UserDefaults.standard.dictionary(forKey: "CurrentUser")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AccountTable.dataSource = self
        AccountTable.delegate = self
        // Do any additional setup after loading the view.
        if let username = userDict?["username"] as? String {
            UserName.text = username
        } else {
            UserName.text = "" // Provide a default value if username is nil
        }
        
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        
        
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
                CurrentUserViewModel.shared.unsaveCurrentUser()
                if let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "Login") as? LoginPage {
                    let navigationController = UINavigationController(rootViewController: loginPage)
                    navigationController.modalPresentationStyle = .fullScreen
                    
                    // Replace the current root with LoginPage
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let delegate = windowScene.delegate as? SceneDelegate {
                        delegate.window?.rootViewController = navigationController
                        delegate.window?.makeKeyAndVisible()
                    }
                }
                    
            }))
             
            present(actionSheet, animated: true)
        
    }
    

    func authenticate(MyString : String) {
        let context = LAContext()
        var error: NSError?

        // Check if the device supports biometrics
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate to change \(MyString)"

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Push to ChangePage after successful authentication
                         
                            let Change = self.storyboard?.instantiateViewController(withIdentifier: "Change") as! ChangePage
                            Change.keyword = MyString
                            self.navigationController?.pushViewController(Change, animated: true)
                        
                        
                    } else {
                        // Handle error
                        let alert = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
        } else {
            // Biometry not available, fallback to other options
            let alert = UIAlertController(title: "Biometrics not available", message: "Your device does not support Face ID or Touch ID.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }


}
