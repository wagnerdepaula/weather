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
    var location:Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // Remove blank cells from tableView
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "History"
        // History button
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(self.onClear))
        
        
        let loc = UserDefaults.standard.stringArray(forKey: "location")
        //print(loc)
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
            viewController.location = self.location
        }
    }
    
    func deselectRow(){
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func onClear() {
       print("Clear History")
    }
    
}
