//
//  DetailPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 02/09/2024.
//

import UIKit

class DetailPage: UIViewController {
    let notify = NotificationHandler()
    var mycar : Car?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
