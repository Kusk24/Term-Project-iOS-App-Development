//
//  SignupPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit

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
    var MyPassword : String!
    
    private var viewModel = PersonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addImage(textField: Username, img: UIImage(systemName: "person.fill")!)
        addImage(textField: Email, img: UIImage(systemName: "envelope.fill")!)
        addImage(textField: Password, img: UIImage(systemName: "lock.fill")!)
        addImage(textField: ConfirmPassword, img: UIImage(systemName: "lock.fill")!)
        
        ConfirmButton.layer.cornerRadius = 15
        ConfirmButton.configuration?.cornerStyle = .capsule
        ConfirmButton.layer.masksToBounds = true
    }
    
    @IBAction func ConfirmClicked(_ sender: Any) {

        let login = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginPage
        
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func UsernameEditingChanged(_ sender: Any) {
        if let currentInput = Username.text {
            if currentInput.count < 4{
                UsernameError.textColor = .systemRed
                UsernameError.text = "Username must be at least 4 Characters"
            } else {
                UsernameError.text = ""
                if viewModel.CheckUsername(Username: currentInput){
                    UsernameError.textColor = .systemRed
                    UsernameError.text = "Username Unavailable"
                } else {
                    UsernameError.textColor = .systemGreen
                    UsernameError.text = "Username Available"
                }
            }
        } 
        
    }
    
    @IBAction func EmailEditingChanged(_ sender: Any) {
        if let currentInput = Email.text {
            if currentInput.contains("@") && currentInput.contains("."){
                EmailError.text = ""
            } else {
                EmailError.text = "wrong email address"
            }
        }
    }

    @IBAction func PasswordEditingChanged(_ sender: Any) {
        if let currentInput = Password.text {
            if currentInput.count < 8 {
                PasswordError.textColor = .systemRed
                PasswordError.text = "Passwords must be at least 8 characters"
            } else {
                let specialCharacterSet = CharacterSet.punctuationCharacters
                let uppercaseLetterSet = CharacterSet.uppercaseLetters
                let lowercaseLetterSet = CharacterSet.lowercaseLetters
                
                if currentInput.rangeOfCharacter(from: specialCharacterSet) != nil &&
                   currentInput.rangeOfCharacter(from: uppercaseLetterSet) != nil &&
                   currentInput.rangeOfCharacter(from: lowercaseLetterSet) != nil {
                    PasswordError.text = ""
                    MyPassword = Password.text
                } else {
                    PasswordError.text = "Must include a special character, uppercase, and lowercase"
                }
            }
        }
    }
    
    @IBAction func ConfirmPasswordEditingChanged(_ sender: Any) {
        if let currentInput = ConfirmPassword.text {
            if currentInput == MyPassword{
                ConfirmPasswordError.textColor = .systemGreen
                ConfirmPasswordError.text = "Password Matched"
            } else {
                ConfirmPasswordError.textColor = .systemRed
                ConfirmPasswordError.text = "Password does not match"
            }
        }
    }
    
}
