//
//  ViewController.swift
//  ScrollView
//
//  Created by Raúl Torres on 14/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let lastKid : [String: String] = ["profile": "defaultphoto_2x", "status":"clock"]
    
    var scrollViewWidth = CGFloat()
    public static var featuredArray = [Dictionary<String,String>]()
    
    @IBOutlet weak var profileScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollViewWidth = self.view.frame.size.width * 0.8
        profileScrollView.frame.size.width = scrollViewWidth
        
        print(scrollViewWidth)
        print(self.view.frame.size.width)
        
        for i in 0...1 {
            if i % 2 == 0{
                ViewController.featuredArray.append(["profile": "girl", "status":"clock"])
            } else {
                ViewController.featuredArray.append(["profile": "boy", "status":"clock"])
            }
        }
        
        while ViewController.featuredArray.count < 5 {
            ViewController.featuredArray.append(lastKid)
        }
        
        //featuredArray = [kid1, kid2 , kid3]
        profileScrollView.contentSize = CGSize(width: (scrollViewWidth) * CGFloat(ViewController.featuredArray.count)/2, height: 100)
        
        loadFeatures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadFeatures(){
        for (index,profile) in ViewController.featuredArray.enumerated() {
            if let featureView = Bundle.main.loadNibNamed("Featured", owner: self, options: nil)?.first as? FeaturedView {
             
                let statusImg : UIImageView = {
                    let image = UIImageView()
                    image.tag = 10
                    image.translatesAutoresizingMaskIntoConstraints = false
                    image.image = #imageLiteral(resourceName: "cool-circle-designs-png-1")
                    image.contentMode = .scaleAspectFit
                    image.frame.size.width = 5
                    image.frame.size.height = 5
                    image.isHidden = true
                    return image
                }()
                

                
                featureView.profileImageBtn.setBackgroundImage(UIImage(named: profile["profile"]!), for: .normal)
                //featureView.statusImage.image = UIImage(named: profile["status"]!)
                featureView.myLabel.text = "index: \(index)"
                
                featureView.helperView.addSubview(statusImg)
                
                
                if featureView.profileImageBtn.backgroundImage(for: .normal) == #imageLiteral(resourceName: "defaultphoto_2x"){
                    //featureView.statusImage.image = nil
                    //statusImg.image = nil
                    featureView.progresLabel.text = "0/100"
                    featureView.exerciseLabel.text = "-"
                } else {
                    featureView.progresLabel.text = "\(((index*3)+95)/(index+1))/100"
                    featureView.exerciseLabel.text = (index % 2 == 0) ? "cheweing" : "reading"
                }
                
                //featureView.statusImage.translatesAutoresizingMaskIntoConstraints = false
                
                let statusHeigth = statusImg.image?.size.height ?? 40
                let profileWidth = featureView.helperView.frame.size.width
                
                statusImg.topAnchor.constraint(equalTo: featureView.profileImageBtn.bottomAnchor, constant: -(statusHeigth)/2).isActive = true
                statusImg.centerXAnchor.constraint(equalTo: featureView.profileImageBtn.centerXAnchor, constant: profileWidth/2).isActive = true
                
                //featureView.statusImage.translatesAutoresizingMaskIntoConstraints = false
                let sh = featureView.statusImage.frame.size.height
                
                featureView.statusImage.topAnchor.constraint(equalTo: featureView.helperView.bottomAnchor, constant: -(sh)/2).isActive = true
                featureView.statusImage.centerXAnchor.constraint(equalTo: featureView.helperView.centerXAnchor, constant: profileWidth/2).isActive = true
                
                
                profileScrollView.addSubview(featureView)
                featureView.frame.size.width = scrollViewWidth/2.5
                featureView.frame.origin.x = (CGFloat(index) * scrollViewWidth/2) + 15
               
            }
        }
    }
    
}

