//
//  ViewController.swift
//  Strong Reference Cycle
//
//  Created by Basem Emara on 5/23/16.
//  Copyright © 2016 Zamzam Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myCar: Car?
    var myDriver: Driver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startStrongReferenceCycleTapped(sender: AnyObject) {
        myCar = Car(plate: "ABC123") // Car instance reference count is 1
        myDriver = Driver(name: "Neo") // Driver instance reference count is 1
         
        myCar?.driver = myDriver // Driver instance reference count is 2
         
        if let car = myCar {
            myDriver?.cars.append(car) // Car instance reference count is 2
        }
         
        myCar = nil // Car instance reference count is 1
        myDriver = nil // Driver instance reference count is 1
        
        // Deinit never called
    }

}

class Car {
    var plate: String
    var driver: Driver?
    
    init(plate: String) {
        self.plate = plate
    }
 
    deinit {
        print("Car deallocated")
    }
}
 
class Driver {
    let name: String
    var cars: [Car] = []
 
    init(name: String) {
        self.name = name
    }
 
    deinit {
        print("Driver deallocated")
    }
}