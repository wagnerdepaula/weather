//
//  CityViewController.swift
//  weather
//
//  Created by Wagner De Paula on 7/22/18.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var woeid:Int!
    var location:Location!
    var days:[Day] = []
    var locations:[String] = [String]()
    var shouldSaveLocation:Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = self.location.title

        // Remove blank cells from tableView
        tableView.tableFooterView = UIView()

        // Get weather conditions for next 5 days
        getWeather()
    }
    
    func getWeather() {
        if let woeid = self.woeid {
            self.tableView.showSpinner()
            Manager.sharedManager().getWeatherFromCity(woeid, completion: { [] (error) in
                if let error = error {
                    print(error)
                } else {
                    DispatchQueue.main.async {
                        self.location = Manager.sharedManager().location
                        self.days = self.location.consolidated_weather!
                        if self.shouldSaveLocation {
                            self.saveLocation(location: self.location)
                        }
                        self.tableView.reloadData()
                        self.tableView.hideSpinner()
                    }
                }
            })
        }
    }
    
    // Save location for history purposes
    func saveLocation(location:Location) {
        if var saved = getLocations() {
            let arr = SavedLocation(title: location.title,
                                location_type: location.location_type,
                                woeid: location.woeid,
                                time_stamp: Date())
            saved.append(arr)
            let data = try! JSONEncoder().encode(saved)
            UserDefaults.standard.set(data, forKey: "loc")
        }
    }
    
    // Get saved locations
    func getLocations() -> [SavedLocation]? {
        if let data = UserDefaults.standard.data(forKey: "loc") {
            let arr = try! JSONDecoder().decode([SavedLocation].self, from: data)
            return arr
        } else {
            return []
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayCell
        let day = days[indexPath.row]
        let max = String(Int(temperatureInFahrenheit(temp: day.max_temp)))
        let min = String(Int(temperatureInFahrenheit(temp: day.min_temp)))
        cell.maxLabel.text = max
        cell.minLabel.text = min
        cell.weatherAbbr = day.weather_state_abbr
        
        cell.dayLabel.text = (indexPath.row == 0) ? "Today" : getDayOfWeek(String(day.applicable_date))
        cell.backgroundColor = (indexPath.row == 0) ? Color.lightBlue : Color.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.row == 0) ? 120.0 : 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow()
    }
    
    func deselectRow(){
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func temperatureInFahrenheit(temp: Double) -> Double {
        let f = temp * 9 / 5 + 32
        return f
    }
    
    func getDayOfWeek(_ day:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: day) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        switch myCalendar.component(.weekday, from: todayDate) {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                print("Error fetching days")
                return "Day"
        }
    }
    
}





// DayCell

class DayCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    var weatherAbbr:String!
    var initialized = false
    let iconUrl = "https://www.metaweather.com/static/img/weather/png/"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard initialized == false else { return }
        initialized = true
        
        // Set icon image
        if let abbr = weatherAbbr {
            weatherImage.loadImage(url: "\(iconUrl)\(abbr).png")
        } else {
            weatherImage.loadImage(url: "\(iconUrl)c.png")
        }
        
        minLabel.font = Font.regular.of(size: 18)
        minLabel.textColor = Color.gray
        maxLabel.font = Font.regular.of(size: 18)
        minLabel.textColor = Color.gray
        dayLabel.font = Font.regular.of(size: 18)
        dayLabel.textColor = Color.gray
    }
}


