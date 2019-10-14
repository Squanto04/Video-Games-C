//
//  JLSearchTableViewCell.swift
//  Video Games-C
//
//  Created by Jordan Lamb on 10/10/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class JLSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameIconImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    var gameItem: JLVideoGame? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let item = gameItem else { return }
        gameTitleLabel.text = item.name
        JLVideoGameController.sharedInstance().fetchIconImage(item) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.gameIconImageView.image = image
                }
            } else {
                print("Image was nil")
            }
        }
    }
}
