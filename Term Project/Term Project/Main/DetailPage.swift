//
//  DetailPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 02/09/2024.
//

import UIKit
import SDWebImage

class DetailPage: UIViewController {
    let notify = NotificationHandler()
    var mycar : Car!
    @IBOutlet weak var Brand: UILabel!
    @IBOutlet weak var Model: UILabel!
    @IBOutlet weak var Year: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Shop: UILabel!
    @IBOutlet weak var Myimages: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Brand.text = mycar.brand
        Model.text = mycar.model
        Year.text = String(mycar.year)
        Price.text = String(mycar.price)
        Shop.text = mycar.location
        Myimages.sd_setImage(with: URL(string: mycar.images[0]))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    

    @IBAction func BookingButtonClicked(_ sender: Any) {
        notify.sendNotification(date: Date(), type: "time", timeInterval: 0.05, title: "Hey there!", body: "You have successfully booked a car")
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
