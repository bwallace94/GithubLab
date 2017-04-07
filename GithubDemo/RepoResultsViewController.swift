//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()
    var repos: [GithubRepo]!
    var filteredRepos: [GithubRepo] = []
    var filterOn = false
    var starMinimumTracker: Int = 0
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell
        if filterOn {
            cell.repo = filteredRepos[indexPath.row]
        } else {
            cell.repo = repos[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repos != nil {
            if filterOn {
                return filteredRepos.count
            } else {
                return repos.count
            }
        }
        return 0
    }
    
    @IBAction func didTapSettings(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        vc.delegate = self
        vc.starMin = starMinimumTracker
        present(vc, animated: true, completion: nil)
    }
    
    func starFilter(filter: SettingsViewController, didPickFilter starMin: Int?) {
        filteredRepos = repos.filter({ (repo) -> Bool in
            let tmp: Int = repo.stars!
            return tmp >= starMin!
        })
        filterOn = true
        self.starMinimumTracker = starMin!
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window

            self.repos = newRepos
            self.tableView.reloadData()

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
//                print(error)
        })
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
