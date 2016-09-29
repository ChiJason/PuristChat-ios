//
//  ViewController.swift
//  PuristChat
//
//  Created by 紀宣志 on 2016/9/8.
//  Copyright © 2016年 JasonChi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myWebView: UIWebView!
    var username:String!
    var password:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myWebView.scalesPageToFit = true
        
        if username != nil && password != nil {
            let myLiveChat = LiveChat(username: username, password: password, mWebView: myWebView)
            myLiveChat.setChatWindows()
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closePage(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

