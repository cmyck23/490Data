//
//  ViewController.swift
//  roadData
//
//  Created by Myckael on 2020-12-27.
//

import UIKit
import CoreMotion
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var motionManager = CMMotionManager()
    
    // Used to start getting the users location
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For use when the app is open & in the background
                locationManager.requestAlwaysAuthorization()
                
                // For use when the app is open
                //locationManager.requestWhenInUseAuthorization()
                
                // If location services is enabled get the users location
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
                    locationManager.startUpdatingLocation()
                }
            }
            
            // Print out the location to the console
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                if let location = locations.first {
                    print(location.coordinate)
                }
            }
            
            // If we have been deined access give the user the option to change it
            func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                if(status == CLAuthorizationStatus.denied) {
                    showLocationDisabledPopUp()
                }
            }
            
            // Show the popup to the user if we have been denied access
            func showLocationDisabledPopUp() {
                let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                        message: "In order to deliver pizza we need your location",
                                                        preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                alertController.addAction(openAction)
                
                self.present(alertController, animated: true, completion: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        motionManager.accelerometerUpdateInterval = 1
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data
            {
                if myData.acceleration.x > 0.5
                {
                    print ("Displaying acceleromter data")
                    print( myData.acceleration.x)
                    print( myData.acceleration.y)
                    print( myData.acceleration.z)
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

