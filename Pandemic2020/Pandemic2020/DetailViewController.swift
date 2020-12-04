//
//  DetailViewController.swift
//  Pandemic2020
//
//  Created by Shilpa S on 04/12/20.
//  Copyright © 2020 Shilpa S. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var country : String = ""
    var allStatus = [Status]()
    
//    Custom init method
    class func `init`(country : String) ->  DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        viewController.country = country
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = String(format:"%@ COVID-19", country)
        self.tableView.allowsSelection = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "DetailCell")
        fetchCountryStatus()
    }
    
//    Network request call to fetch status by Country
    func fetchCountryStatus() {
        Spinner.shared.animate(onView : self.view)
        ServiceRequestManager.shared.getAllStatus(forCountry: self.country, onCompletion: {
            response in
            DispatchQueue.main.async {
                [weak self] in
                Spinner.shared.stop()
                if let weakSelf = self {
                    
                    do {
                        let jsonDecoder = JSONDecoder()
                        let data = try JSONSerialization.data(withJSONObject: response, options: .fragmentsAllowed)
                        weakSelf.allStatus = try jsonDecoder.decode([Status].self, from: data)
                    }
                    catch {
                        weakSelf.allStatus.removeAll()
                        let alert = UIAlertController(title: "Error", message: "No Data found", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                            _ in
                            alert.dismiss(animated: false, completion: nil)
                            weakSelf.navigationController?.popViewController(animated: true)
                        })
                        alert.addAction(okAction)
                        weakSelf.present(alert, animated: true, completion: nil)
                        print(error)
                    }
                    weakSelf.tableView.reloadData()
                }
            }
        })
    }

}

extension DetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.allStatus.isEmpty ? 1 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getDetailsCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let status = self.allStatus.last {
            return "Status as on \(status.date.formattedDateString())"
        }
        return ""
    }
    
//    Configure the display cell
    private func getDetailsCell(at indexPath : IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.selectionStyle = .none
        if let status = self.allStatus.last {
            switch indexPath.row {
                case 0:
                    cell.textLabel?.text = String(format: "Confirmed : %@", String(status.confirmed).formatterNumberString())
                case 1:
                    cell.textLabel?.text = String(format: "Active : %@", String(status.active).formatterNumberString())
                case 2:
                    cell.textLabel?.text = String(format: "Recovered : %@", String(status.recovered).formatterNumberString())
                case 3:
                    cell.textLabel?.text = String(format: "Deaths : %@", String(status.deaths).formatterNumberString())
                default:
                    cell.textLabel?.text = ""
            }
        }
        else {
            cell.textLabel?.text = "No Data Found"
        }
        return cell
    }

}
