//
//  SearchPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit

class SearchPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let IndexPath = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search") as! SearchTableCell
        
//        cell.Myimage.image =
        cell.Brand.text = cars[IndexPath].brand
        cell.Price.text = String(cars[IndexPath].price)
        cell.Model.text = cars[IndexPath].model
        cell.Year.text = String(cars[IndexPath].year)
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
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
