//
//  BuyingPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 30/08/2024.
//

import UIKit
import Alamofire

class BuyingPage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var BuyingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BuyingTable.delegate = self
        BuyingTable.dataSource = self
        BuyingTable.reloadData()
        NotificationHandler().askPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableData()
    }
    
    func reloadTableData() {
        DispatchQueue.main.async {
            if self.isViewLoaded {
                self.BuyingTable.reloadData()
            } else {
                print("View is not loaded yet, cannot reload data.")
            }
        }
    }
    
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
            return 275
        case 1:
            return 275
        case 2:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let BuyingCellOne = cell as? BuyingCellOne {
            // Reload the collection view to ensure it's updated
            BuyingCellOne.collectionView.reloadData()
        }
        if let BuyingCellTwo = cell as? BuyingCellTwo{
            BuyingCellTwo.collectionView.reloadData()
        }
    }
    
}


