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
    private var viewModel: PersonViewModel!
    
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
        viewModel = PersonViewModel()

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

}
