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
    @IBOutlet weak var mystackview: UIStackView!
    @IBOutlet weak var BookingButton: UIButton!
    
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
        
        Myimages.layer.cornerRadius = 10 // Adjust as needed
        Myimages.layer.masksToBounds = true // Clip the image to the rounded corners
        Myimages.layer.borderColor = UIColor.black.cgColor // Border color
        Myimages.layer.borderWidth = 2 // Border width
        
        BookingButton.layer.cornerRadius = 15
        BookingButton.configuration?.cornerStyle = .capsule
        BookingButton.layer.masksToBounds = true
        
        mystackview.backgroundColor = UIColor(white: 0.9, alpha: 0.7)
        
        // If needed, enable layout margins
        
        navigationItem.title = mycar.brand + " " + mycar.model
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    

    @IBAction func BookingButtonClicked(_ sender: Any) {
        guard let daysText = bookingDays.text, !daysText.isEmpty else {
            // Show alert if booking days are not provided
            let alert = UIAlertController(title: "Missing Information",
                                          message: "Please add the number of booking days.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let username = CurrentUserViewModel.shared.loadCurrentUser().username ?? ""
        
        if BookingViewModel.shared.isBooked(id: mycar.id, username: username) {
            let alert = UIAlertController(title: "Please choose another car",
                                          message: "You have already booked this car",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        } else {
            // Create confirmation alert
            let confirmAlert = UIAlertController(title: "Confirm Booking",
                                                 message: "Are you sure you want to book this car for \(daysText) days?",
                                                 preferredStyle: .alert)

            // Add Cancel action
            confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            // Add Confirm action
            confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                // Proceed with adding the booking
                BookingViewModel.shared.addBooking(carID: self.mycar.id, username: username, bookingDate: daysText)

                // Notify user of successful booking
                self.notify.sendNotification(date: Date(), type: "time", timeInterval: 0.05, title: "Hey there!", body: "You have successfully booked a car")
            }))
            
            // Present the confirmation alert
            present(confirmAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func bookingDaysEditingChanged(_ sender: Any) {
        if let daysText = bookingDays.text, !daysText.isEmpty {
            TotalPrice.text = "$" + String(Int(daysText)! * mycar.price)
        } else {
            TotalPrice.text = "$"
        }
    }
    

}
