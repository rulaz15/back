//
//  ViewController.swift
//  BlueTracker
//
//  Created by Raúl Torres on 14/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

    var centralManeger : CBCentralManager?
    var timer : Timer?
    var peripheralsArray = [(name: String, RSSI: NSNumber)]()
    
    
    @IBOutlet var myTableView: UITableView!
    
    @IBAction func refreshBarBtnAction(_ sender: Any) {
        startScan()
        startTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centralManeger = CBCentralManager(delegate: self, queue: nil)
        
        
    }

    func startScan(){
        peripheralsArray.removeAll()
        myTableView.reloadData()
        centralManeger?.stopScan()
        centralManeger?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { (timer) in
            self.startScan()
        }
    }
    
    func showAlert(title : String? = "error", msg: String){
        let alertC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertA = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertC.addAction(alertA)
        self.present(alertC, animated: true, completion: nil)
    }
}

extension ViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("ok")
            startScan()
            startTimer()
        default:
            showAlert(msg: "revisar el bluetooth")
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        peripheralsArray.append((name: peripheral.name ?? peripheral.identifier.uuidString, RSSI: RSSI))
        myTableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripheralsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.nameLabel.text = peripheralsArray[indexPath.row].name
        cell.secondLabel.text = "RSSI: \(peripheralsArray[indexPath.row].RSSI)"
        return cell
    }
    
    
}

