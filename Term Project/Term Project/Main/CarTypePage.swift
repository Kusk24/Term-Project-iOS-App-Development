//
//  CarTypePage.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/09/2024.
//

import UIKit
import SDWebImage

class CarTypePage: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carTypeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellFour", for: indexPath) as! CollectionCellFour
        
        let i = indexPath.row
        cell.Myimages.sd_setImage(with: URL(string: (carTypeList[i].images[0])))
        cell.Brand.text = carTypeList[i].brand
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let Detail = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailPage
        let i = indexPath.row
        Detail.mycar = carTypeList[i]
        navigationController?.pushViewController(Detail, animated: true)
    }

    var cartype : String = ""
    @IBOutlet weak var collectionView: UICollectionView!
    var carTypeList: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationItem.title = cartype
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carTypeList = CarViewModel.shared.getCarList().filter { $0.type == cartype }
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
