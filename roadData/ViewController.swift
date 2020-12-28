//
//  ViewController.swift
//  roadData
//
//  Created by Myckael on 2020-12-27.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
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
                    print ("DO SOMETHING SPCIAL")
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

