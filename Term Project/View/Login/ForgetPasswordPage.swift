//
//  ForgetPasswordPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit
import KeychainAccess

class ForgetPasswordPage: UIViewController {
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var NewPassword: UITextField!
    @IBOutlet weak var ConfirmNewPassword: UITextField!
    @IBOutlet weak var UsernameError: UILabel!
    @IBOutlet weak var EmailError: UILabel!
    @IBOutlet weak var NewPasswordError: UILabel!
    @IBOutlet weak var ConfirmNewPasswordError: UILabel!
    @IBOutlet weak var ConfirmChangesButton: UIButton!
    
    var MyPassword : String!
    
    let userViewModel = UserViewModel(keychainService: KeychainService(service: "com.612054.Term-Project"))
        
    override func viewDidLoad() {
        super.viewDidLoad()

            // Setup UI icons for text fields
        addImage(textField: Username, img: UIImage(systemName: "person.fill")!)
        addImage(textField: Email, img: UIImage(systemName: "envelope.fill")!)
        addImage(textField: NewPassword, img: UIImage(systemName: "lock.fill")!)
        addImage(textField: ConfirmNewPassword, img: UIImage(systemName: "lock.fill")!)
            
            // Customize Confirm button
        ConfirmChangesButton.layer.cornerRadius = 15
        ConfirmChangesButton.configuration?.cornerStyle = .capsule
        ConfirmChangesButton.layer.masksToBounds = true
    }
    
    @IBAction func ConfirmChangesClicked(_ sender: Any) {
        
        if validatePasswords() {
            do {
                // Update the password for the given username using ViewModel
                try userViewModel.updateUserPassword(username: Username.text!, newPassword: NewPassword.text!)
                
                // Debugging: Print to verify the password update
                print("Updated in Keychain: Username - \(Username.text!), New Password - \(NewPassword.text!)")
                
                // Navigate to login page
                navigateToLoginPage()
            } catch let error {
                ConfirmNewPasswordError.text = "Failed to update password: \(error.localizedDescription)"
            }
        } else {
            ConfirmNewPasswordError.text = "Passwords do not match or are invalid"
        }
    }
    
    
    
    @IBAction func UsernameEditingChanged(_ sender: Any) {
        guard let currentUsername = Username.text, currentUsername.count >= 4 else {
            UsernameError.textColor = .systemRed
            UsernameError.text = "Username must be at least 4 characters"
            return
        }

        // Check if username exists using ViewModel
        if userViewModel.isUsernameAvailable(username: currentUsername) {
            UsernameError.textColor = .systemRed
            UsernameError.text = "Username does not exist"
        } else {
            UsernameError.text = ""
        }
    }
    
    @IBAction func EmailEditingChanged(_ sender: Any) {
        guard let currentUsername = Username.text, let currentEmail = Email.text else {
            return
        }
        
        // Check if the email matches the one stored in the Keychain
        if userViewModel.doesEmailMatch(username: currentUsername, email: currentEmail) {
            EmailError.text = ""
        } else {
            EmailError.textColor = .systemRed
            EmailError.text = "Incorrect email or no email associated with this username"
        }
    }
    
    @IBAction func NewPasswordEditingChanged(_ sender: Any) {
        guard let currentInput = NewPassword.text else { return }
        
        if currentInput.count < 8 {
            NewPasswordError.textColor = .systemRed
            NewPasswordError.text = "Password must be at least 8 characters"
        } else if isValidPassword(currentInput) {
            NewPasswordError.text = ""
            MyPassword = currentInput
        } else {
            NewPasswordError.textColor = .systemRed
            NewPasswordError.text = "Must include a special character, uppercase, and lowercase"
        }
    }
    
    @IBAction func NewConfirmPasswordEditingChanged(_ sender: Any) {
        guard let currentInput = ConfirmNewPassword.text, let originalPassword = MyPassword else { return }
        
        if currentInput == originalPassword {
            ConfirmNewPasswordError.textColor = .systemGreen
            ConfirmNewPasswordError.text = "Password Matched"
        } else {
            ConfirmNewPasswordError.textColor = .systemRed
            ConfirmNewPasswordError.text = "Password does not match"
        }
    }
    
    func validatePasswords() -> Bool {
        guard let newPassword = NewPassword.text, let confirmPassword = ConfirmNewPassword.text else {
            return false
        }
        
        if newPassword.count < 8 {
            NewPasswordError.textColor = .systemRed
            NewPasswordError.text = "Password must be at least 8 characters"
            return false
        } else if newPassword != confirmPassword {
            ConfirmNewPasswordError.textColor = .systemRed
            ConfirmNewPasswordError.text = "Passwords do not match"
            return false
        } else {
            NewPasswordError.text = ""
            ConfirmNewPasswordError.text = ""
            return true
        }
    }
    
    // Helper function to validate password strength
    func isValidPassword(_ password: String) -> Bool {
        let specialCharacterSet = CharacterSet.punctuationCharacters
        let uppercaseLetterSet = CharacterSet.uppercaseLetters
        let lowercaseLetterSet = CharacterSet.lowercaseLetters
        
        return password.rangeOfCharacter(from: specialCharacterSet) != nil &&
               password.rangeOfCharacter(from: uppercaseLetterSet) != nil &&
               password.rangeOfCharacter(from: lowercaseLetterSet) != nil
    }

    // Navigate to the login page after successfully updating the password
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
    
}
