//
//  ForgetPasswordPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addImage(textField: Username, img: UIImage(systemName: "person.fill")!)
        addImage(textField: Email, img:UIImage(systemName: "envelope.fill")!)
        addImage(textField: NewPassword, img: UIImage(systemName: "lock.fill")!)
        addImage(textField: ConfirmNewPassword, img: UIImage(systemName: "lock.fill")!)
        
        ConfirmChangesButton.layer.cornerRadius = 15
        ConfirmChangesButton.configuration?.cornerStyle = .capsule
        ConfirmChangesButton.layer.masksToBounds = true

    }
    
    @IBAction func ConfirmChangesClicked(_ sender: Any) {
        let login = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginPage
        
        login.modalPresentationStyle = .fullScreen
        present(login , animated: true)
    }
    
    
    @IBAction func UsernameEditingChanged(_ sender: Any) {
        if let currentInput = Username.text {
            if currentInput.count < 4{
                UsernameError.textColor = .systemRed
                UsernameError.text = "Username must be at least 4 Characters"
            } else {
                UsernameError.text = ""
                if UserInfo.CheckUsername(Username: currentInput){
                    UsernameError.textColor = .systemGreen
                    UsernameError.text = ""
                } else {
                    UsernameError.textColor = .systemRed
                    UsernameError.text = "Username does not exist"
                }
            }
        }
    }
    
    @IBAction func EmailEditingChanged(_ sender: Any) {
        if let currentUsername = Username.text,
           let currentEmail = Email.text{
            if UserInfo.CheckEmail(Username: currentUsername, Email: currentEmail){
                EmailError.text = ""
            }else {
                EmailError.text = "Incorrect Email"
            }
        }
    }
    
    @IBAction func NewPasswordEditingChanged(_ sender: Any) {
        if let currentInput = NewPassword.text {
            if currentInput.count < 8 {
                NewPasswordError.textColor = .systemRed
                NewPasswordError.text = "Passwords must be at least 8 characters"
            } else {
                let specialCharacterSet = CharacterSet.punctuationCharacters
                let uppercaseLetterSet = CharacterSet.uppercaseLetters
                let lowercaseLetterSet = CharacterSet.lowercaseLetters
                
                if currentInput.rangeOfCharacter(from: specialCharacterSet) != nil &&
                   currentInput.rangeOfCharacter(from: uppercaseLetterSet) != nil &&
                   currentInput.rangeOfCharacter(from: lowercaseLetterSet) != nil {
                    NewPasswordError.text = ""
                    MyPassword = NewPassword.text
                } else {
                    NewPasswordError.text = "Must include a special character, uppercase, and lowercase"
                }
            }
        }
    }
    
    @IBAction func NewConfirmPasswordEditingChanged(_ sender: Any) {
        if let currentInput = ConfirmNewPassword.text {
            if currentInput == MyPassword{
                ConfirmNewPasswordError.textColor = .systemGreen
                ConfirmNewPasswordError.text = "Password Matched"
            } else {
                ConfirmNewPasswordError.textColor = .systemRed
                ConfirmNewPasswordError.text = "Password does not match"
            }
        }
    }
    
    
}
