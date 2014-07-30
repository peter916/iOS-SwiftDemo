//
//  ViewController.swift
//  swiftOne
//
//  Created by peter on 14-7-16.
//  Copyright (c) 2014 org.peter. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet var longitude: UILabel
    @IBOutlet var latitude: UILabel
    @IBOutlet var loadingIndicator: UIActivityIndicatorView
    let locationManager:CLLocationManager = CLLocationManager()
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.loadingIndicator.startAnimating()
        
        //let backbround = UIImage(named:"background.png")
       // self.view.backgroundColor = UIColor(patternImage: backbround)
        
        
        //1.key point
        if ( ios8() ) {
            locationManager.requestAlwaysAuthorization()
        }
        
        //2
        locationManager.startUpdatingLocation()
    
    }
    
    func ios8()->Bool {
        return UIDevice.currentDevice().systemVersion == "8.0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //3
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!){
        
        self.loadingIndicator.hidden = true
        self.loadingIndicator.stopAnimating()
        
        
        var location:CLLocation = locations[locations.count-1] as CLLocation
        
        if ( location.horizontalAccuracy > 0 ) {
            self.latitude.text = "\(location.coordinate.latitude)"
            self.longitude.text = "\(location.coordinate.longitude)"
            
            let manager = AFHTTPRequestOperationManager()
            let url = "https://api.douban.com/v2/movie/us_box"
            //let params = ["lat":self.latitude.text,"lon":self.longitude.text,"cnt":0]
            
            manager.GET(url, parameters: nil, success:{(operation:AFHTTPRequestOperation!,responseObject:AnyObject!) in
                    println("JSON:"+responseObject.description!)
                }, failure: {(operation:AFHTTPRequestOperation!, error:NSError!) in
                    println("error:"+error.description!)
                })
            
            locationManager.stopUpdatingLocation()
        }
        
        
    }
    
    //4
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println(error)
    }
    
    //5 add NSLocationAlwaysUsageDescription,NSLocationWhenInUseUsageDescription in info.plist


}

