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
    @IBOutlet weak var `Type`: UILabel!
    @IBOutlet weak var bookingDays: UITextField!
    @IBOutlet weak var TotalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Brand.text = mycar.brand
        Model.text = mycar.model
        Year.text = String(mycar.year)
        Price.textColor = .systemGreen
        Price.text = "$"+String(mycar.price)
        Shop.text = mycar.location
        Myimages.sd_setImage(with: URL(string: mycar.images[0]))
        `Type`.text = mycar.type
        // Do any additional setup after loading the view.
        
        navigationItem.title = mycar.brand + " " + mycar.model
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    

    @IBAction func BookingButtonClicked(_ sender: Any) {
        guard let daysText = bookingDays.text, !daysText.isEmpty else {
                // Show alert if booking days are not provided
                let alert = UIAlertController(title: "Missing Information", message: "Please add the number of booking days.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
        }
        
        if BookingViewModel.shared.isBooked(id: mycar.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "") {
            let alert = UIAlertController(title: "Please choose another car", message: "You have already booked this car", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        } else {
            BookingViewModel.shared.addBooking(carID: mycar.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "", bookingDate: bookingDays.text!)
        }
        
        notify.sendNotification(date: Date(), type: "time", timeInterval: 0.05, title: "Hey there!", body: "You have successfully booked a car")
    }
    
    @IBAction func bookingDaysEditingChanged(_ sender: Any) {
        if let daysText = bookingDays.text, !daysText.isEmpty {
            TotalPrice.text = "$" + String(Int(daysText)! * mycar.price)
        } else {
            TotalPrice.text = "$"
        }
    }
    

}
