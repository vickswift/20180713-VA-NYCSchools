//
//  MainHighSchoolViewController.swift
//  20180713-VA-NYCSchools
//
//  Created by Victor  Adu on 7/13/18.
//  Copyright © 2018 Filmic. All rights reserved.
//

import UIKit

class MainHighSchoolViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataService = DataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NYC Schools"
        dataService.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        DataService.instance.getAllNYCHighSchools()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.deselectSelectedRow(animated: true)
    }

    //MARK: - Segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destination as! DetailHighSchoolViewController
                destinationViewController.selectedHighSchool = DataService.instance.highSchools[indexPath.row]
            }
        }
    }
    
}

extension MainHighSchoolViewController: DataServiceDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - DataServiceDelegate method
    func highSchoolsLoaded() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    func highSchoolsAvgSATScoresLoaded() {
    }
    
    //MARK: - UITableDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.highSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HighSchoolCell", for: indexPath) as? HighSchoolCell {
            cell.configureCell(name: dataService.highSchools[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }

}

extension UITableView {
    
    //MARK: - Helper method
    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow
        {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
    
}

