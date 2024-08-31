//
//  BuyingPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 30/08/2024.
//

import UIKit

class BuyingPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BuyingCellOne") as! BuyingCellOne
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BuyingCellTwo") as! BuyingCellTwo
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BuyingCellThree") as! BuyingCellThree
            return cell
        default:
            fatalError("Unexpected Index Path")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 200
        case 2:
            return 150
        default:
            return UITableView.automaticDimension
        }
    }

    @IBOutlet weak var BuyingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BuyingTable.delegate = self
        BuyingTable.dataSource = self
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
