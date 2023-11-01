//
//  ViewController.swift
//  Countries
//
//  Created by Omar Hesham on 9/18/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = CountriesViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCountries()
        setupUI()
    }
    
    func setupUI() {
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCells")
        searchBar.delegate = self
        searchBar.isHidden = false
    }

    
    func fetchCountries() {
        activityIndicator.startAnimating()
        Task {
            await viewModel.fetchCountries()
            self.tableView.reloadData()
            
            if let errorMessage = self.viewModel.errorMessage {
                self.presentErrorMessage(message: errorMessage)
            }
            self.activityIndicator.stopAnimating()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCountries.count // Use filteredCountries for the number of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCells", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let countryInfo = viewModel.filteredCountries[indexPath.row] // Use filteredCountries
        cell.updateUI(countriesInfo: countryInfo)
        
        return cell
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCountriesBy(name: searchText)
        tableView.reloadData()
    }
    
    // Any other UISearchBarDelegate methods would go here.
}
