//
//  MainViewController.swift
//  Pandemic2020
//
//  Created by Shilpa S on 03/12/20.
//  Copyright © 2020 Shilpa S. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var countriesListView: UITableView!
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Countries"
        self.countriesListView.allowsMultipleSelection = false
        self.countriesListView.isEditing = false
        self.countriesListView.delegate = self
        self.countriesListView.dataSource = self
        self.countriesListView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "CountryNameCell")
        
        fetchCountries()
    }
    
//    Network request call to fetch the countries
    private func fetchCountries() {
        Spinner.shared.animate(onView: self.view)
        ServiceRequestManager.shared.getCountries(onCompletion: {
            response in
            DispatchQueue.main.async {
                [weak self] in
                if let weakSelf = self {
                    Spinner.shared.stop()
                    do {
                        let jsonDecoder = JSONDecoder()
                        let data = try JSONSerialization.data(withJSONObject: response, options: .fragmentsAllowed)
                        weakSelf.countries = try jsonDecoder.decode([Country].self, from: data)
                        weakSelf.countries.sort(by: {$0.country < $1.country })
                    }
                    catch {
                        print(error)
                    }
                    weakSelf.countriesListView.reloadData()
                }
            }
        })
    }

}

extension MainViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryNameCell = getContryNameCell(at: indexPath)
        return countryNameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController.`init`(country: countries[indexPath.row].country)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
//    MARK: Helper method to create the table view cell.
//    The cell will be configured with country name from the list
    private func getContryNameCell(at indexPath : IndexPath) -> UITableViewCell {
        let cell = countriesListView.dequeueReusableCell(withIdentifier:"CountryNameCell" , for: indexPath)
        cell.textLabel?.text = self.countries[indexPath.row].country
        cell.selectionStyle = .none
        return cell
        
    }
}

