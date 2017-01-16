//
//  ViewController.swift
//  BeaconList
//
//  Created by hsin0202 on 2016/11/3.
//  Copyright © 2016年 hsin0202. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,ESTBeaconManagerDelegate {

    @IBOutlet weak var MytableView: UITableView!
    
    //var beaconList : [CLBeacon] = []
    var sortedBeacons : [CLBeacon] = []
    //var names = ["Mark","Clyde","Buck","Steve","Wallace"]
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "estimote")
    
    func startRangingBeacons() {
        beaconManager.requestWhenInUseAuthorization()
        beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
           // _ = beacons.filter(){ $0.accuracy > 0.0 }
            sortedBeacons = beacons.filter(){ $0.accuracy > 0.0 }.sorted(){ $0.accuracy < $1.accuracy }
        
            MytableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedBeacons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let beacon : CLBeacon = beaconList[indexPath.row]
        let beacon : CLBeacon = sortedBeacons[indexPath.row]
        let cell = self.MytableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.Major.text = "Major = " + beacon.major.int32Value.description
        cell.minor.text = "minor = " + beacon.minor.int32Value.description
        cell.RSSI.text =  "RSSI = " + beacon.rssi.description
        cell.Distance.text = "Dist = " + Float(beacon.accuracy).description
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 3. Set the beacon manager's delegate
        self.beaconManager.delegate = self
        // 4. We need to request this authorization for every beacon manager
        self.beaconManager.requestAlwaysAuthorization()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeacons(in: self.beaconRegion)
        print("will")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeacons(in: self.beaconRegion)
    }

}

