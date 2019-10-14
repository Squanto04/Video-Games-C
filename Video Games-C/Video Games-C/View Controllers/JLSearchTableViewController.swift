//
//  JLSearchTableViewController.swift
//  Video Games-C
//
//  Created by Jordan Lamb on 10/10/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class JLSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var videoGames: [JLVideoGame] = []

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoGames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameListCell", for: indexPath) as? JLSearchTableViewCell else { return UITableViewCell()}
        let games = videoGames[indexPath.row]
        cell.gameItem = games
        cell.updateViews()
        return cell
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
            !searchText.isEmpty
            else { return }
        self.searchBar.resignFirstResponder()
        JLVideoGameController.sharedInstance().fetchGames(with: searchText) { (searchResults) in
            self.videoGames = searchResults
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameDetailVC" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            guard let destinationVC = segue.destination as? JLGameDetailViewController else { return }
            let objectToSend = videoGames[index.row]
            destinationVC.videoGames = objectToSend
        }
    }

}
