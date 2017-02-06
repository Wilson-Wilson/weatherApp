//
//  ViewController.swift
//  weatherApp
//
//  Created by Wilson on 2017-02-05.
//  Copyright © 2017 com.Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var weatherLabel: UILabel!
    
    let url:URL = URL(string: "http://www.weather-forecast.com/locations/London/forecasts/latest")!
    
    
    @IBAction func searchButton(_ sender: Any) {
        var message = ""
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response , error in
            
            if error != nil {
                
                message = "Weather at that location could not be loaded.  Please try again later"
                
            } else {
                if let unwrappedData = data {
                    let dataString = String(data: unwrappedData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                    
                    var delimiter = "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    if let content = dataString?.components(separatedBy: delimiter) {
                        
                        if content.count > 0 {
                            delimiter = "</span>"
                            let weather = content[1].components(separatedBy: delimiter)
                            
                            if weather.count > 0 {
                                message = weather[0].replacingOccurrences(of: "&deg:", with: "°")
                            }
                        }
                    }
                }
            }
            
            if message == "" {
                message = "Weather at that location could not be loaded.  Please try again later"
            }
            
            DispatchQueue.main.sync(execute: {
                self.weatherLabel.text = message
            })
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

