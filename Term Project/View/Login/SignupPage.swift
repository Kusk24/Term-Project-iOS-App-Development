//
//  SignupPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit
import KeychainAccess

class SignupPage: UIViewController {
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var UsernameError: UILabel!
    @IBOutlet weak var EmailError: UILabel!
    @IBOutlet weak var PasswordError: UILabel!
    @IBOutlet weak var ConfirmPasswordError: UILabel!
    @IBOutlet weak var SignupError: UILabel!
    var CorrectUsername = false
    var CorrectPassword = false
    var CorrectEmail = false
    var CorrectConfirmPassword = false
    var MyPassword : String!
    
    let userViewModel = UserViewModel(keychainService: KeychainService(service: "com.612054.Term-Project"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI icons for text fields
        addImage(textField: Username, img: UIImage(systemName: "person.fill")!)
        addImage(textField: Email, img: UIImage(systemName: "envelope.fill")!)
        addImage(textField: Password, img: UIImage(systemName: "lock.fill")!)
        addImage(textField: ConfirmPassword, img: UIImage(systemName: "lock.fill")!)
        
        // Customize Confirm button
        ConfirmButton.layer.cornerRadius = 15
        ConfirmButton.configuration?.cornerStyle = .capsule
        ConfirmButton.layer.masksToBounds = true
    }
    
    @IBAction func ConfirmClicked(_ sender: Any) {
        if CorrectUsername && CorrectPassword && CorrectEmail && CorrectConfirmPassword {
            do {
                // Call ViewModel to create the new user
                try userViewModel.signupUser(username: Username.text!, email: Email.text!, password: Password.text!)
                
                // Navigate to login page
                navigateToLoginPage()
            } catch let error {
                SignupError.text = "Signup failed: \(error.localizedDescription)"
            }
        } else {
            SignupError.text = "Please correct the highlighted fields."
        }
        
    }
    
    @IBAction func UsernameEditingChanged(_ sender: Any) {
        if let currentInput = Username.text {
            if currentInput.count < 4 {
                UsernameError.textColor = .systemRed
                UsernameError.text = "Username must be at least 4 characters"
                CorrectUsername = false
            } else {
                // Check username availability using ViewModel
                if userViewModel.isUsernameAvailable(username: currentInput) {
                    UsernameError.textColor = .systemGreen
                    UsernameError.text = "Username Available"
                    CorrectUsername = true
                } else {
                    UsernameError.textColor = .systemRed
                    UsernameError.text = "Username Unavailable"
                    CorrectUsername = false
                }
            }
        }
    }
    
    @IBAction func EmailEditingChanged(_ sender: Any) {
        if let currentInput = Email.text {
            if isValidEmail(currentInput) {
                EmailError.text = ""
                CorrectEmail = true
            } else {
                EmailError.textColor = .systemRed
                EmailError.text = "Invalid Email Address"
                CorrectEmail = false
            }
        }
    }
    
    @IBAction func PasswordEditingChanged(_ sender: Any) {
        if let currentInput = Password.text {
            if currentInput.count < 8 {
                PasswordError.textColor = .systemRed
                PasswordError.text = "Password must be at least 8 characters"
                CorrectPassword = false
            } else if isValidPassword(currentInput) {
                PasswordError.text = ""
                MyPassword = currentInput
                CorrectPassword = true
            } else {
                PasswordError.textColor = .systemRed
                PasswordError.text = "Password must contain a special character, uppercase, and lowercase"
                CorrectPassword = false
            }
        }
    }
    
    @IBAction func ConfirmPasswordEditingChanged(_ sender: Any) {
        if let currentInput = ConfirmPassword.text, let originalPassword = MyPassword {
            if currentInput == originalPassword {
                ConfirmPasswordError.textColor = .systemGreen
                ConfirmPasswordError.text = "Password Matched"
                CorrectConfirmPassword = true
            } else {
                ConfirmPasswordError.textColor = .systemRed
                ConfirmPasswordError.text = "Password does not match"
                CorrectConfirmPassword = false
            }
        }
        
        
    }
    
    private func navigateToLoginPage() {
        if let loginPage = storyboard?.instantiateViewController(withIdentifier: "Login") as? LoginPage {
            let navigationController = UINavigationController(rootViewController: loginPage)
            navigationController.modalPresentationStyle = .fullScreen
            
            // Replace the current root with LoginPage
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let delegate = windowScene.delegate as? SceneDelegate {
                delegate.window?.rootViewController = navigationController
                delegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    // Helper function to check if an email is valid
    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    // Helper function to validate password strength
    private func isValidPassword(_ password: String) -> Bool {
        let specialCharacterSet = CharacterSet.punctuationCharacters
        let uppercaseLetterSet = CharacterSet.uppercaseLetters
        let lowercaseLetterSet = CharacterSet.lowercaseLetters
        
        return password.rangeOfCharacter(from: specialCharacterSet) != nil &&
        password.rangeOfCharacter(from: uppercaseLetterSet) != nil &&
        password.rangeOfCharacter(from: lowercaseLetterSet) != nil
    }
}
