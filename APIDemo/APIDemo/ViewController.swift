//
//  ViewController.swift
//  APIDemo
//
//  Created by Raúl Torres on 03/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=8a76f26543079101c6a8fa03c68b9c87")
        
        
        var request = URLRequest(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
                        let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")

            do {
                let info = try JSONDecoder().decode(AllJson.self, from: data)
                print(info.coord)
            } catch {
                print(error)
            }
            
//            let decoder = JSONDecoder()
//
//            if let response = try? decoder.decode(AllJson.self, from: data){
//
//                print(response)
//            }
        }.resume()
    }
    
    
}

