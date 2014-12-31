//
//  ViewController.swift
//  BeaconColor
//
//  Created by Joseph Mari on 12/1/14.
//  Copyright (c) 2014 Joseph Mari. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "Estimotes")
    let colors = [
        56505: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        5917: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        27327: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println(beacons)
        
        //convert beacons to a a string
        let myBeacon: String = beacons.description
        let myBeaconArr = myBeacon.componentsSeparatedByString(",")
        println(myBeaconArr[0])
        println(myBeaconArr[1])
        println(myBeaconArr[2])
        println(myBeaconArr[3])
        println(myBeaconArr[4])
        
        //turn string into a dictionary
        var beaconDic: [String: String] = ["UUID": myBeaconArr[0], "Major": myBeaconArr[1], "Minor": myBeaconArr[2], "Proximity": myBeaconArr[3], "RSSI": myBeaconArr[4]]
        
        //var jsonError: NSError?
        //let decodedJSON = NSJSONSerialization.JSONObjectWithData(beaconDic, options: nil, error: &jsonError)
        //if !(jsonError != nil) {
        //    println(decodedJSON["UUID"])
        //}

        
        //let data: NSData = beaconString
        //var jsonError: NSError?
        //let decodedJson = NSJSONSerialization.JSONObjectWithData(beaconString, options: nil, error: &jsonError)
        //if !(jsonError != nil) {
        //    println(decodedJson["title"])
        //}
        
        //println(decodedJson)
        
        //JSON conversion
        //let json = JSON(CLBeacon)
        //json.toString()
        //println(json)
        
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self;
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

