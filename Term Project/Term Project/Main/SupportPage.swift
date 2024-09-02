//
//  SupportPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit

class SupportPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupportTableCell") as! SupportTableCell
        
        if indexPath.row == 0{
            cell.imageView?.image = UIImage(systemName: "person.fill")
        } else {
            cell.imageView?.image = UIImage(systemName: "heart.fill")
        }
        return cell
    }
    

    @IBOutlet weak var SupportTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SupportTable.dataSource = self
        SupportTable.delegate = self
        // Do any additional setup after loading the view.
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
