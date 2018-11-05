//
//  ViewController.swift
//  Json
//
//  Created by Raúl Torres on 14/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

struct Course: Decodable {
    let id : Int?
    let name: String?
    let link: String?
    let imageUrl: String?
}

class ViewController: UIViewController {
    
    var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: jsonUrlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //check error
            //check response 200 ok
            
            guard let data = data else {
                return
            }
            
            //let dataAsString = String(data: data, encoding: .utf8)
            //print(dataAsString)
            let decoder = JSONDecoder()
    
            if let coursesList = try? decoder.decode([Course].self, from: data){
                //print(coursesList[1])
                for c in coursesList {
                    self.courses.append(c)
                    print(c.name)
                }
            }

            print("CURSOS: \(self.courses[1].id)")
            /*do {
                
                let courses = try JSONDecoder().decode([Course].self, from: data)
                print(courses)
                
            } catch let err {
                print("deserealization error \(err)")
            } */
            
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

