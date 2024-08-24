//
//  ViewController.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit

class LoginPage: UIViewController {
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var UsernameError: UILabel!
    @IBOutlet weak var PasswordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        addImage(textField: Username, img: UIImage(systemName: "person.fill")!)
        addImage(textField: Password, img: UIImage(systemName: "lock.fill")!)
        LoginButton.layer.cornerRadius = 15
        LoginButton.configuration?.cornerStyle = .capsule
        LoginButton.layer.masksToBounds = true
    }
    
    @IBAction func LoginClicked(_ sender: Any) {
        let Main = storyboard?.instantiateViewController(withIdentifier: "Main") as! MainPage
        
        Main.modalPresentationStyle = .popover
        present(Main, animated: true)
    }
    
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
    
}

