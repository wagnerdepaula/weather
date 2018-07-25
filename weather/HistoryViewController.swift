//
//  HistoryViewController.swift
//  weather
//
//  Created by Wagner De Paula on 7/23/18.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    var locations:[SavedLocation] = [SavedLocation]()
    var location:SavedLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove blank cells from tableView
        tableView.tableFooterView = UIView()
        
        // Get saved locations
        // getSaveLocations()
        
        loadLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "History"
    }
    
    func loadLocations() {
        if let data = UserDefaults.standard.data(forKey: "loc") {
            let arr = try! JSONDecoder().decode([SavedLocation].self, from: data)
            
            self.locations = arr.sorted(by: { $0.time_stamp.compare($1.time_stamp) == .orderedDescending })
            self.tableView.reloadData()
            self.tableView.hideSpinner()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        let city = locations[indexPath.row]
        cell.titleLabel.text = city.title
        cell.woeidLabel.text = String(city.woeid)
        
        // set up time stamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US")
        let time = dateFormatter.string(from: city.time_stamp)
        cell.timestampLabel.text = time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.location = locations[indexPath.row]
        self.performSegue(withIdentifier: "LocationViewController", sender: self)
        deselectRow()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LocationViewController") {
            let viewController = segue.destination as! LocationViewController
            viewController.woeid = self.location.woeid
        }
    }
    
    func deselectRow(){
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}





// HistoryCell

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var woeidLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    var initialized = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard initialized == false else { return }
        initialized = true
        titleLabel.font = Font.medium.of(size: 18)
        titleLabel.textColor = Color.darkGray
        woeidLabel.font = Font.regular.of(size: 16)
        woeidLabel.textColor = Color.gray
        timestampLabel.font = Font.regular.of(size: 16)
        timestampLabel.textColor = Color.gray
    }
}
