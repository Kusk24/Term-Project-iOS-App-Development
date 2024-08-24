//
//  ViewController.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        addImage(textField: Username, img: UIImage(systemName: "person.fill")!)
        addImage(textField: Password, img: UIImage(systemName: "lock.fill")!)
    }


}

