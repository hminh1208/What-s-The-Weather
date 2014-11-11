//
//  ViewController.swift
//  What's The Weather
//
//  Created by minh phan on 11/11/14.
//  Copyright (c) 2014 minh phan. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        self.view.endEditing(true)
        
        
        var urlString = "http://www.weather-forecast.com/locations/"+city.text.stringByReplacingOccurrencesOfString(" ", withString: "")+"/forecasts/latest"
        
        var url = NSURL(string: urlString)
        
       
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
            
           println(response)
            
            let tempurlContent: String = urlContent as String
            
            if (urlContent! as NSString).containsString("<span class=\"phrase\">") {
                
                var contentArray = (urlContent! as NSString).componentsSeparatedByString("<span class=\"phrase\">")
                
                var newContentArray = contentArray[1].componentsSeparatedByString("</span>")
                
                var weatherForcast = newContentArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.result.text = weatherForcast
                    
                }
                
            } else {
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.result.text = "Could not find that city - please try again"
                }
            }
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

