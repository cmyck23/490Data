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
    
    //Create the the image view and connect it between the StoryBoard and the  swift code.
    @IBOutlet var imageView: UIImageView!
    //Create the the button connect it between the StoryBoard and the  swift code.
    @IBOutlet var button:UIButton!
    
    
    //--This is button that activates the camera.
    @IBAction func didTapButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present (picker,animated: true)
        
    }
    
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
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            print(location.coordinate)
//        }
//    }
    
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
        motionManager.accelerometerUpdateInterval = 0.2
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data
            {
                //--This is to create a date object to display the time later.
                print("-------------------------")
                let currentDateTime = Date()
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                formatter.dateStyle = .long
                let dateTimeString = formatter.string(from: currentDateTime)
                
                //-Print time
                print (dateTimeString)
                
                print ("Displaying latitude and longitude (GPS DATA)")
                print(self.locationManager.location!.coordinate.latitude)
                print(self.locationManager.location!.coordinate.longitude)
                
                print ("Displaying accelerometer data")
                print( myData.acceleration.x)
                print( myData.acceleration.y)
                print( myData.acceleration.z)
                    
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any])
    {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage else {
            return
        }
        
        imageView.image = image
        
        //--Trying to save photo into album
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
    }
    
}


