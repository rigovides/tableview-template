//
//  ViewController.swift
//  MyBrowser
//
//  Created by usuario on 11/2/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goButtonAction(_ sender: Any) {
        guard let urlString = self.urlTextField.text, let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        self.webView.load(request)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.webView.goBack()
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        self.webView.reload()
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        self.webView.goForward()
    }
}

