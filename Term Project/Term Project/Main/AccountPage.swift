//
//  AccountPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit

class AccountPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableCell") as! AccountTableCell
        let i = indexPath.row
        if i == 0{
            cell.textLabel?.text = "Change Username"
        }else if i == 2{
            cell.textLabel?.text = "Change Password"
        } else{
            cell.textLabel?.text = "Change Email"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    @IBOutlet weak var AccountTable: UITableView!
    @IBOutlet weak var UserName: UILabel!
    let userDict = UserDefaults.standard.dictionary(forKey: "CurrentUser")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AccountTable.dataSource = self
        AccountTable.delegate = self
        // Do any additional setup after loading the view.
        if let username = userDict?["username"] as? String {
            UserName.text = username
        } else {
            UserName.text = "" // Provide a default value if username is nil
        }
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        unsaveCurrentUser()
        let Login = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginPage
        
        Login.modalPresentationStyle = .fullScreen
        present(Login, animated: true)
        
    }
    

}
