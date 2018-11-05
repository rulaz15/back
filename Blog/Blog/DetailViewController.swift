//
//  DetailViewController.swift
//  Blog
//
//  Created by Raúl Torres on 03/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {


    @IBOutlet var webView: WKWebView!
    
    func configureView() {
        // Update the user interface for the detail item.
        
        
        if let detail = detailItem {
            self.title = detail.value(forKey: "title") as? String
            if let web = webView {
                web.loadHTMLString((detail.value(forKey: "content") as? String)!, baseURL: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

