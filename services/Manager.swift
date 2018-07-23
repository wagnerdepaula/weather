//
//  Manager.swift
//  weather
//
//  Created by Wagner De Paula on 7/21/18.
//

import UIKit
import MapKit


class Manager: NSObject {
    
    var api = "https://www.metaweather.com/api/location/search"
    var locations: [Location] = []
    var location: Location!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var lat: Double = 0
    var long: Double = 0
    
    
    class func sharedManager() -> Manager {
        struct Static {
            static let instance = Manager()
        }
        return Static.instance
    }
    
    
    func searchCity(_ query: String, completion: ((Error?) -> ())?) {
        
        let entry = query.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(api)/?query=\(entry)")
        let request = NSMutableURLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            if let data = data {
                let decoder: JSONDecoder = JSONDecoder()
                do {
                    self.locations = try decoder.decode([Location].self, from: data)
                    completion?(nil)
                } catch {
                    completion?(error)
                }
            }
        })
        task.resume()
    }
    
    
    func getWeatherFromCity(_ woeid: Int, completion: ((Error?) -> ())?) {
        
        let url = URL(string: "\(api)/location/\(woeid)")
        let request = NSMutableURLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            if let data = data {
                let decoder: JSONDecoder = JSONDecoder()
                do {
                    self.location = try decoder.decode(Location.self, from: data)
                    completion?(nil)
                } catch {
                    completion?(error)
                }
            }
        })
        task.resume()
    }
    
    
    
    
    
    func searchCityWithCoordinate(_ query: String, completion: ((Error?) -> ())?) {
        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location!
            lat = (currentLocation?.coordinate.latitude)!
            long = (currentLocation?.coordinate.longitude)!
        }

//        let parameter: [String: String] = [
//            "ll": "\(lat),\(long)"
//        ]
//
//        guard let gitUrl = URL(string: "\(url)/?query=\(entry)") else { return }
//
//        URLSession.shared.dataTask(with: gitUrl) { (data, response, error) in
//            guard let data = data else { return }
//            do {
//                let decoder = JSONDecoder()
//                self.locations = try decoder.decode([Location].self, from: data)
//            } catch let err {
//                print("Err", err)
//            }
//            }.resume()
    }
    
    
    
}
