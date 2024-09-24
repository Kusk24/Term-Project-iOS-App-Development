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
    @IBOutlet weak var SigninSSOButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addImage(textField: Username, img: UIImage(systemName: "person.fill")!)
        addImage(textField: Password, img: UIImage(systemName: "lock.fill")!)
        LoginButton.layer.cornerRadius = 15
        LoginButton.configuration?.cornerStyle = .capsule
        LoginButton.layer.masksToBounds = true
        
        SigninSSOButton.layer.cornerRadius = 15
        SigninSSOButton.configuration?.cornerStyle = .capsule
        SigninSSOButton.layer.masksToBounds = true
        
        // for Password Mask
        Password.isSecureTextEntry = true
        // Optional: Customize the font and text color of the password field
//        Password.font = UIFont.systemFont(ofSize: 18)
        Password.textColor = UIColor.black
        
//        print(Keychain(service: "com.612054.Term-Project"))
//        print(UserInfo.persons)
        
//        let url = "https://mocki.io/v1/a5ea996a-042f-418f-8cdb-0bac9954417f"
//
//        AF.request(url).responseDecodable(of: CarsResponse.self) { data in
//            switch data.result {
//            case .success(let carResponse):
//                cars = carResponse.cars
//                print(cars)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentUser = CurrentUserViewModel.shared.loadCurrentUser()
        if currentUser.isLoggedIn {
            // Navigate to main screen if user is already logged in
            let Main = storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
            Main.modalPresentationStyle = .fullScreen
            present(Main, animated: true)
        } else {
            print("No user is logged in")
        }
    }
    
    @IBAction func LoginClicked(_ sender: Any) {
        if let username = Username.text, !username.isEmpty,
           let password = Password.text, !password.isEmpty {
            
            let keychain = Keychain(service: "com.612054.Term-Project")
                        
            do {
                if let storedPassword = try keychain.get(Username.text!) {
                    
                    CurrentUserViewModel.shared.saveCurrentUser(isLoggedIn: true, username: username)
                    print("User saved in UserDefaults")

                    // Debugging: Print to verify what's being retrieved
                    print("Retrieved from Keychain: Username - \(username), Stored Password - \(storedPassword)")

                    if storedPassword == password {
                        let Main = storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
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
                UsernameError.textColor = .systemRed
                UsernameError.text = "Username Required!!!"
            }
            if Password.text!.isEmpty {
                PasswordError.textColor = .systemRed
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
    
    @IBAction func SigninSSOClicked(_ sender: Any) {
        let SigninSSO = storyboard?.instantiateViewController(identifier: "SigninSSO") as! SigninSSOPage
            navigationController?.pushViewController(SigninSSO, animated: true)
    }
    
}

