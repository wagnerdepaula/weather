//
//  ViewController.swift
//  weather
//
//  Created by Wagner De Paula on 7/21/18.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locations:[Location] = [Location]()
    var location:Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Search Bar
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = Color.blue
        searchBar.placeholder = "Location, City"
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 8, vertical: 0)
        searchBar.setTextColor(color: Color.white)
        searchBar.setTextFieldColor(color: Color.blue)
        searchBar.setPlaceholderTextColor(color: Color.white.withAlphaComponent(0.4))
        searchBar.setSearchImageColor(color: Color.white)
        searchBar.setTextFieldClearButtonColor(color: Color.white)
        
        // Remove blank cells from tableView
        tableView.tableFooterView = UIView()

        // Try to search using coordinates
        searchCityWithCoordinates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Weather"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(self.showHistory))
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text
        // Close keyboard
        searchBar.endEditing(true)
        if(query!.isEmpty){
            print("Nothing input for search")
        } else {
            searchCity(query: query!)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count <= 0 {
            locations = []
            tableView.reloadData()
        }
    }
    
    func searchCity(query:String) {
        Manager.sharedManager().searchCity(query, completion: { [] (error) in
            if let error = error {
                print(error)
            } else {
                self.locations = Manager.sharedManager().locations
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    
    func searchCityWithCoordinates() {
        Manager.sharedManager().searchCityWithCoordinate(completion: { [] (error) in
            if let error = error {
                print(error)
            } else {
                self.locations = [Manager.sharedManager().locations[0]]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationCell
        let city = locations[indexPath.row]
        cell.titleLabel.text = city.title
        cell.woeidLabel.text = String(city.woeid)
        cell.coordinatesLabel.text = city.latt_long
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
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
            viewController.shouldSaveLocation = true
        }
    }
    
    func deselectRow(){
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    @objc func showHistory() {
        self.performSegue(withIdentifier: "HistoryViewController", sender: self)
    }
    
}


// LocationCell
class LocationCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var woeidTitleLabel: UILabel!
    @IBOutlet weak var woeidLabel: UILabel!
    @IBOutlet weak var coordinatesTitleLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    var initialized = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard initialized == false else { return }
        initialized = true
        
        // Set cell styles
        titleLabel.font = Font.medium.of(size: 18)
        titleLabel.textColor = Color.blue
        
        woeidTitleLabel.font = Font.medium.of(size: 12)
        woeidTitleLabel.textColor = Color.gray
        woeidTitleLabel.text = "WOEID"
        woeidLabel.font = Font.regular.of(size: 12)
        woeidLabel.textColor = Color.gray
        
        coordinatesTitleLabel.font = Font.medium.of(size: 12)
        coordinatesTitleLabel.textColor = Color.gray
        coordinatesTitleLabel.text = "COORDINATES"
        coordinatesLabel.font = Font.regular.of(size: 12)
        coordinatesLabel.textColor = Color.gray
    }
}




