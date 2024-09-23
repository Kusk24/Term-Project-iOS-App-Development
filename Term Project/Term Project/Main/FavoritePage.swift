//
//  FavoritePage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit

class FavoritePage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getFavorites().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableCell") as! FavoriteTableCell
        
        let id = getFavorites()[i].id
        cell.Brand.text = String(CarViewModel.shared.getCarBrand(id: id) ?? "")
        cell.Model.text = CarViewModel.shared.getCarModel(id: id) ?? ""
        cell.Year.text = String(CarViewModel.shared.getCarYear(id: id) ?? "")
        cell.Price.text = "$"+String(CarViewModel.shared.getCarPrice(id: id) ?? "")
        checkFavorite(myButton: cell.FavoriteButton, id: getFavorites()[i].id)
        cell.Myimage.sd_setImage(with: URL(string: CarViewModel.shared.getCarImage(id: id) ?? ""))
        cell.FavoriteButton.tag = i
        cell.FavoriteButton.addTarget(self, action: #selector(FavoriteButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        let Detail = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailPage
        Detail.mycar = getFavorites()[i]
        navigationController?.pushViewController(Detail, animated: true)
    }
    
    @IBOutlet weak var FavoriteTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FavoriteTable.dataSource = self
        FavoriteTable.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if FavoriteHome == true {
            FavoriteHome = false
        }
        FavoriteTable.reloadData()
    }
    
    @objc func FavoriteButtonTapped(_ sender: UIButton) {
        let carIndex = sender.tag
        let car = getFavorites()[carIndex]
        
        // Toggle the favorite status
        if isFavorite(id: car.id) {
            removeFavorite(id: car.id)
        }
        
        // Update the button's appearance
        checkFavorite(myButton: sender, id: car.id)
        FavoriteTable.reloadData()
        // Reload the collection view data (optional: only reload affected item)
        FavoriteTable.reloadRows(at: [IndexPath(row: carIndex, section: 0)], with: .automatic)
    }
    

}
