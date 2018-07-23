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
    var locations:[Location] = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // Remove blank cells from tableView
        tableView.tableFooterView = UIView()
        
       
        getSaveLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "History"
    }
    
    func getSaveLocations() {
        if let savedLocations = UserDefaults.standard.stringArray(forKey: "locations") {
            for loc in savedLocations {
                let woeid = Int(loc)!
                Manager.sharedManager().getWeatherFromCity(woeid, completion: { [] (error) in
                    if let error = error {
                        print(error)
                    } else {
                        DispatchQueue.main.async {
                            // Check saved locations and update tableview
                            if let location = Manager.sharedManager().location {
                               self.locations.append(location)
                                if (self.locations.count == savedLocations.count) {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                })
            }
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
        cell.timeLabel.text = city.location_type
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.location = locations[indexPath.row]
        //self.performSegue(withIdentifier: "LocationViewController", sender: self)
        deselectRow()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LocationViewController") {
            //let viewController = segue.destination as! LocationViewController
            //viewController.location = self.location
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
    @IBOutlet weak var timeLabel: UILabel!
    var initialized = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard initialized == false else { return }
        initialized = true
        
        titleLabel.font = Font.medium.of(size: 18)
        titleLabel.textColor = Color.blue
        
        woeidLabel.font = Font.regular.of(size: 16)
        woeidLabel.textColor = Color.gray
        
        timeLabel.font = Font.regular.of(size: 16)
        timeLabel.textColor = Color.gray

    }
}
