//
//  CityViewController.swift
//  weather
//
//  Created by Wagner De Paula on 7/22/18.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var location:Location!
    var days:[Day] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.location.title
        
        // Remove blank cells from tableView
        tableView.tableFooterView = UIView()
        
        getWeather()
    }
    
    func getWeather() {
        if let woeid = location?.woeid {
            Manager.sharedManager().getWeatherFromCity(woeid, completion: { [] (error) in
                if let error = error {
                    print(error)
                } else {
                    DispatchQueue.main.async {
                        self.location = Manager.sharedManager().location
                        self.days = self.location.consolidated_weather!
                        self.tableView.reloadData()
                    }
                }
            })
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
        cell.weatherLabel.text = day.weather_state_name
        cell.maxLabel.text = max
        cell.minLabel.text = min
        cell.weatherAbbr = day.weather_state_abbr
        cell.dayLabel.text = getDayOfWeek(String(day.applicable_date))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
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
                return "Monday"
            case 2:
                return "Tuesday"
            case 3:
                return "Wednesday"
            case 4:
                return "Thursday"
            case 5:
                return "Friday"
            case 6:
                return "Saturday"
            case 7:
                return "Sunday"
            default:
                print("Error fetching days")
                return "Day"
        }
    }

    
}





// DayCell

class DayCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
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
        
        weatherLabel.font = Font.medium.of(size: 18)
        weatherLabel.textColor = Color.blue
        
        minLabel.font = Font.regular.of(size: 16)
        minLabel.textColor = Color.gray
        
        maxLabel.font = Font.regular.of(size: 16)
        minLabel.textColor = Color.gray
        
        dayLabel.font = Font.regular.of(size: 14)
        dayLabel.textColor = Color.gray
    }
}

