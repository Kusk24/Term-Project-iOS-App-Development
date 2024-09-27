//
//  ViewController.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit
import KeychainAccess
import Alamofire


class LoginPage: UIViewController {
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var UsernameError: UILabel!
    @IBOutlet weak var PasswordError: UILabel!
    @IBOutlet weak var LoginError: UILabel!
    
    // ViewModel instances
    let userViewModel = UserViewModel(keychainService: KeychainService(service: "com.612054.Term-Project"))
    let currentUserViewModel = CurrentUserViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add icons to text fields
        addImage(textField: Username, img: UIImage(systemName: "person.fill")!)
        addImage(textField: Password, img: UIImage(systemName: "lock.fill")!)

        // Customize login button
        LoginButton.layer.cornerRadius = 15
        LoginButton.configuration?.cornerStyle = .capsule
        LoginButton.layer.masksToBounds = true
        
        // Password settings
        Password.isSecureTextEntry = true
        Password.textColor = UIColor.black
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Check if a user is already logged in
        let currentUser = currentUserViewModel.loadCurrentUser()
        if currentUser.isLoggedIn {
            navigateToMainTabBar()
        }
    }
    
    @IBAction func LoginClicked(_ sender: Any) {
        guard let username = Username.text, !username.isEmpty,
              let password = Password.text, !password.isEmpty else {
            showValidationErrors()
            return
        }

        // Try to login using UserViewModel
        let loginSuccess = userViewModel.loginUser(username: username, password: password)

        if loginSuccess {
            // Login successful, update current user state
            let currentUser = currentUser(isLoggedIn: true, username: username)
            currentUserViewModel.saveCurrentUser(currentUser)
            
            // Navigate to MainTabBar
            navigateToMainTabBar()
        } else {
            // Login failed, show error
            LoginError.text = "Invalid username or password"
        }
    }
    
    @IBAction func SignupClicked(_ sender: Any) {
        let signup = storyboard?.instantiateViewController(withIdentifier: "Signup") as! SignupPage
        navigationController?.pushViewController(signup, animated: true)
    }
    
    @IBAction func ForgetPasswordClicked(_ sender: Any) {
        let Forget = storyboard?.instantiateViewController(withIdentifier: "ForgetPassword") as! ForgetPasswordPage
        navigationController?.pushViewController(Forget, animated: true)
    }
    
    @IBAction func UsernameEditingChanged(_ sender: Any) {
        if let currentInput = Username.text{
            if currentInput.count < 4 {
                UsernameError.textColor = .systemRed
                UsernameError.text = "Username must be at least 4 Characters"
            } else {
                UsernameError.textColor = .systemGreen
                UsernameError.text = "✓"
            }
        }
    }
    
    @IBAction func PasswordEditingChanged(_ sender: Any) {
        if let currentInput = Password.text{
            if currentInput.count < 8 {
                PasswordError.textColor = .systemRed
                PasswordError.text = "Passwords must be at least 8 Characters"
            } else {
                PasswordError.textColor = .systemGreen
                PasswordError.text = "✓"
            }
            
            //            if currentInput.isEmpty {
            //                UsernameError.textColor = .systemRed
            //                UsernameError.text = ""
            //            }
        }
        
    }
    
    private func showValidationErrors() {
        if Username.text!.isEmpty {
            UsernameError.textColor = .systemRed
            UsernameError.text = "Username Required!"
        }
        if Password.text!.isEmpty {
            PasswordError.textColor = .systemRed
            PasswordError.text = "Password Required!"
        }
    }

    // Navigate to the main tab bar controller
    private func navigateToMainTabBar() {
        let mainTabBar = storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
        mainTabBar.modalPresentationStyle = .fullScreen
        present(mainTabBar, animated: true)
    }
    
}

