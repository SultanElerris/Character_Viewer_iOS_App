//
//  HomeViewController.swift
//  SimpsonsViewer
//
//  Created by Sultan Sultan on 12/15/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import UIKit

protocol CellSelectionDelegate: class {
    func cellSelected(with data: Character?)
}

class CharacterHomeViewController: UITableViewController {
    
    // Mark: Properties
    
    // View Model
    let viewModel = CharacterHomeViewModel()
    // Cell Selection Delegate
    weak var delegate: CellSelectionDelegate?
    // Search Controller
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Table View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the title as large title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // set the page title based on the scheme
        switch Configuration.CurrentConfigFile.appType {
        case .wire: self.title = "Wire"
        case .simpsons : self.title = "Simpsons"
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Setup the search bar
        setupSearchBar()
        
        // Set the viewModel as self
        viewModel.delegate = self
        
        // Get data from viewModel
        viewModel.fetchAllCharacters()
        
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
    
}
// MARK: - Table view data source
extension CharacterHomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCharactersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let chatacter = viewModel.filteredCharactersArray[indexPath.row]
        cell.textLabel?.text = chatacter.name
        return cell
    }
}

// Mark: - Table View delegate
extension CharacterHomeViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = viewModel.filteredCharactersArray[indexPath.row]
        delegate?.cellSelected(with: selectedCell)
        if
            let detailsViewController = delegate as? CharacterDetailsViewController,
            let detailNavigationController = detailsViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

// Mark:- SearchBar Delegate Methods
extension CharacterHomeViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            viewModel.filterCharacters(searchText: searchText)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchController.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

extension CharacterHomeViewController: CharacterViewModelDelegateProtocol {
    func didUpdateData() {
        DispatchQueue.main.async { // Reload table view when the data is fetched.
            self.tableView.reloadData()
        }
    }
}
