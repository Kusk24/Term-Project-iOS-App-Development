//
//  SupportPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit
import AVKit

class SupportPage: UIViewController, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var videoThumbnailView: UIImageView!
    
    var playerController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UIDevice.current.userInterfaceIdiom == .pad {
            videoThumbnailView.contentMode = .scaleAspectFit
        } else {
            videoThumbnailView.contentMode = .scaleAspectFill // Or your preferred mode for other devices
        }
        
        videoThumbnailView.image = UIImage(named: "CarThumbNail")
        videoThumbnailView.layer.cornerRadius = 10 // Adjust as needed
        videoThumbnailView.layer.masksToBounds = true // Clip the image to the rounded corners
        videoThumbnailView.layer.borderColor = UIColor.black.cgColor // Border color
        videoThumbnailView.layer.borderWidth = 2 // Border width
        // Set up the tap gesture on the videoThumbnailView
        setupTapGesture()
        
    }
    
    // Set up the tap gesture recognizer for the video thumbnail view
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        videoThumbnailView.isUserInteractionEnabled = true
        videoThumbnailView.addGestureRecognizer(tapGesture)
        
        // Optional: Add some corner radius if you want rounded corners
        videoThumbnailView.layer.cornerRadius = 10
        videoThumbnailView.clipsToBounds = true
    }
    
    // Action to play the video when the thumbnail is tapped
    @objc func playVideo() {
        // URL for the video
        guard let url = URL(string: "https://www.dropbox.com/scl/fi/djxt85zvwi7wvr9gkvpam/Guide-1.mp4?rlkey=4kqzdnqsm7crx14g18q2f1wa3&st=p0rm8opa&raw=1") else { return }
        
        let player = AVPlayer(url: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        
        // Present the AVPlayerViewController to play the video
        present(playerController, animated: true) {
            self.playerController.player?.play()
        }
    }
    
}
