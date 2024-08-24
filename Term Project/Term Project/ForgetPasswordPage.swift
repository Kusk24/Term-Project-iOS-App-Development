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
    @IBOutlet weak var EmailError: UIStackView!
    @IBOutlet weak var NewPasswordError: UILabel!
    @IBOutlet weak var ConfirmNewPasswordError: UIStackView!
    
    @IBOutlet weak var ConfirmChangesButton: UIButton!
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
