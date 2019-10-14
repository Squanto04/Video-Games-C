//
//  JLGameDetailViewController.swift
//  Video Games-C
//
//  Created by Jordan Lamb on 10/10/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class JLGameDetailViewController: UIViewController {
    
    var videoGames: JLVideoGame?
    
    @IBOutlet weak var gameCoverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var gameDescription: UITextView!
    @IBOutlet weak var websiteButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        guard let gameID = videoGames?.gameGUID else { return }
        self.title = gameID
    }
    
    @IBAction func toWebsiteButton(_ sender: Any) {
        websiteAlert()
    }
    
    func updateViews() {
        guard let videoGames = videoGames else { return }
            titleLabel.text = videoGames.name
        if videoGames.rating == ""{
            ratingLabel.text = "No Rating"
        } else {
            ratingLabel.text = videoGames.rating
        }
        guard let platform = videoGames.platforms else { return }
        if platform.count == 0 {
            platformLabel.text = "Unknown"
        } else {
            platformLabel.text = platform.joined(separator: ", ")
        }
        guard let gameDesc = videoGames.gameDescription else { return }
        if gameDesc != nil {
                gameDescription.text = "No game description available."
            } else {
                gameDescription.text = videoGames.gameDescription
            }
        guard let website = videoGames.siteDetailURL else { return }
        if website.count > 0 {
            websiteButton.isEnabled = true
        } else {
            websiteButton.isEnabled = false
        }
        
        JLVideoGameController.sharedInstance().fetchSuperImage(videoGames) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.gameCoverImageView.image = image
            }
        }
    }
    
    func websiteAlert() {
        guard let website = videoGames?.siteDetailURL,
            let title = videoGames?.name
            else { return }
        let websiteAlert = UIAlertController(title: title, message: "Find more information about this game on Giant Bombs Website.", preferredStyle: .actionSheet)
        let openWebPage = UIAlertAction(title: "Take Me There", style: .default) { (_) in
            guard let gameURL = URL(string: website) else { return }
            UIApplication.shared.open(gameURL)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        websiteAlert.addAction(openWebPage)
        websiteAlert.addAction(cancelAction)
        present(websiteAlert, animated: true, completion: nil)
    }
}
