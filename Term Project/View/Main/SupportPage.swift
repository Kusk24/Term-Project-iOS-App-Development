//
//  SupportPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit
import AVKit

class SupportPage: UIViewController, AVPlayerViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    var playerController = AVPlayerViewController()
    
    @IBAction func WatchButtonClicked(_ sender: Any) {
        guard let url = URL(string: "https://www.dropbox.com/scl/fi/djxt85zvwi7wvr9gkvpam/Guide-1.mp4?rlkey=4kqzdnqsm7crx14g18q2f1wa3&st=p0rm8opa&raw=1") else { return }
        
        let player = AVPlayer(url: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = true
        playerController.delegate = self
        playerController.player?.play()
        self.present(playerController, animated: true, completion: nil)
    
    }
    
}
