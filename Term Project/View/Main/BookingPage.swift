//
//  BookingPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit

class BookingPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let Username = CurrentUserViewModel.shared.loadCurrentUser().username!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        BookingViewModel.shared.getBookings(username: Username).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell") as! BookingCell
        let i = indexPath.row
        let booking = BookingViewModel.shared.getBookings(username: Username)[i]
        
        cell.Myimages.sd_setImage(with: URL(string: booking.car.images[0]))
        cell.BookingDays.text = "Expires in \(booking.date) days"
        cell.Brand.text = booking.car.brand
        cell.CancelButton.tag = i
        cell.ShopButton.tag = i
        cell.CancelButton.addTarget(self, action: #selector(CancelClicked(_:)), for: .touchUpInside)
        cell.ShopButton.addTarget(self, action: #selector(ShopClicked(_:)), for: .touchUpInside)
        cell.TotalCost.text = "Cost = $ \(Int(booking.date)! * booking.car.price)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    @IBOutlet weak var BookingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BookingTable.dataSource = self
        BookingTable.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if BookingHome == true {
            BookingHome = false
        }
        BookingTable.reloadData()
    }

    @objc func CancelClicked(_ sender: UIButton) {
        let i = sender.tag
        let bookings = BookingViewModel.shared.getBookings(username: Username)
        
        if i < bookings.count {  // Ensure index is valid
            let booking = bookings[i]
            BookingViewModel.shared.removeBooking(bookingID: booking.id, username: Username)
            print("Booking cancelled for ID: \(booking.id)")
            BookingTable.reloadData()  // Reload data after cancelling
        } else {
            print("Invalid index for cancel action: \(i)")
        }
    }
    
    @objc func ShopClicked(_ sender: UIButton) {
        let i = sender.tag
        let booking = BookingViewModel.shared.getBookings(username: Username)[i]
        let ShopPage = storyboard?.instantiateViewController(withIdentifier: "OurShop") as! OurShopPage
        
        let shop = booking.car.location
        ShopPage.shop = shop
        navigationController?.pushViewController(ShopPage, animated: true)
    }
}
