//
//  ViewController.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit
import KeychainAccess

class LoginPage: UIViewController {
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var UsernameError: UILabel!
    @IBOutlet weak var PasswordError: UILabel!
    @IBOutlet weak var LoginError: UILabel!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addImage(textField: Username, img: UIImage(systemName: "person.fill")!)
        addImage(textField: Password, img: UIImage(systemName: "lock.fill")!)
        LoginButton.layer.cornerRadius = 15
        LoginButton.configuration?.cornerStyle = .capsule
        LoginButton.layer.masksToBounds = true
        
        // for Password Mask
        Password.isSecureTextEntry = true
        // Optional: Customize the font and text color of the password field
        Password.font = UIFont.systemFont(ofSize: 18)
        Password.textColor = UIColor.black
    }
    
    @IBAction func LoginClicked(_ sender: Any) {
        if let username = Username.text, !username.isEmpty,
           let password = Password.text, !password.isEmpty {
            
            let keychain = Keychain(service: "com.612054.Term-Project")
                        
            do {
                if let storedPassword = try keychain.get(Username.text!) {
                    
                    // Debugging: Print to verify what's being retrieved
                    print("Retrieved from Keychain: Username - \(username), Stored Password - \(storedPassword)")

                    if storedPassword == password {
                        let Main = storyboard?.instantiateViewController(withIdentifier: "Main") as! MainPage
                        Main.modalPresentationStyle = .fullScreen
                        present(Main, animated: true)
                    } else {
                        LoginError.text = "Incorrect Password"
                    }
                } else {
                    LoginError.text = "User Does Not Exist. Please Sign up"
                }
            } catch let error {
                LoginError.text = "Failed to retrieve credentials: \(error)"
                print("Keychain retrieval error: \(error)")
            }
            
        } else {
            if Username.text!.isEmpty {
                UsernameError.text = "Username Required!!!"
            }
            if Password.text!.isEmpty {
                PasswordError.text = "Password Required!!!"
            }
        }
    }

            
            
//            if (UserInfo.CheckPerson(Username: username, Passwords: password) && PasswordBoolean) {
//                let Main = storyboard?.instantiateViewController(withIdentifier: "Main") as! MainPage
//                Main.modalPresentationStyle = .fullScreen
//                present(Main, animated: true)
//            }else if ((UserInfo.CheckPerson(Username: username, Passwords: password) && !PasswordBoolean)){
//                LoginError.text = "Incorrect Password"
//            } else{
//                LoginError.text = "User Does Not Exist. Please Sign up"
//            }
//        } else {
//            if(Username.text!.isEmpty){
//                UsernameError.text = "Username Required!!!"
//            }
//            if(Password.text!.isEmpty){
//                PasswordError.text = "Password Required!!!"
//            }
//        }
//    }
    
    @IBAction func SignupClicked(_ sender: Any) {
        let signup = storyboard?.instantiateViewController(withIdentifier: "Signup") as! SignupPage
        
        
        signup.modalPresentationStyle = .popover
        present(signup, animated: true)
    }
    
    @IBAction func ForgetPasswordClicked(_ sender: Any) {
        let Forget = storyboard?.instantiateViewController(withIdentifier: "ForgetPassword") as! ForgetPasswordPage
        
        Forget.modalPresentationStyle = .popover
        present(Forget, animated: true)
    }
    
    @IBAction func UsernameEditingChanged(_ sender: Any) {
        if let currentInput = Username.text{
            if currentInput.count < 4 {
                UsernameError.text = "Username must be at least 4 Characters"
            } else {
                UsernameError.text = ""
            }
        }
    }
    
    @IBAction func PasswordEditingChanged(_ sender: Any) {
        if let currentInput = Password.text{
            if currentInput.count < 8 {
                PasswordError.text = "Passwords must be at least 8 Characters"
            } else {
                PasswordError.text = ""
            }
        }

    }
    
}

