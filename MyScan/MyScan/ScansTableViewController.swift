//
//  ScansTableViewController.swift
//  MyScan
//
//  Created by Raúl Torres on 17/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit



class ScansTableViewController: UITableViewController {

    
    var scansArray = [(code: String, type: String, tapped: Bool)]() // code/type
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scansArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let row = scansArray[indexPath.row]
        cell.textLabel?.text = row.tapped ? row.code : row.type
        cell.selectionStyle = .none
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        scansArray[indexPath.row].tapped = !scansArray[indexPath.row].tapped
        let row = scansArray[indexPath.row]
        cell?.textLabel?.text = row.tapped ? row.code : row.type
    }

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newScan" {
            let destVC = segue.destination as! ViewController
            destVC.scanDelegate = self
        }
    }


}

extension ScansTableViewController: ScanDelegate {
    
    func addScan(code: String, type: String) {
        scansArray.append((code: code, type: type, tapped: true))
        tableView.reloadData()
    }
}
