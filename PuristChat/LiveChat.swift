//
//  LiveChat.swift
//  PuristChat
//
//  Created by 紀宣志 on 2016/9/10.
//  Copyright © 2016年 JasonChi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

public class LiveChat {
    
    private let registerUrl = "https://api.puristit.com/register"
    private let initializeUrl = "https://api.puristit.com/initialize"
    private var chatUrl:String!
    private let clientappKey = "ydNHyu6SxFBdmzU2QNOvVnIOUKefuQy"
    private var username:String!
    private var password:String!
    private var p_username:String!
    private let platform = "iOS"
    private var chatView:UIWebView!
    private var myUUID:String!
    private var param = [String : String](), param1 = [String: String]()
    
    
    
    init(username:String, password:String, mWebView:UIWebView){
        
        self.username = username
        self.password = password
        self.chatView = mWebView
        self.myUUID = NSUUID().UUIDString
        
        self.param = [
            "username":self.username,
            "password":self.password,
            "platform":self.platform,
            "name": self.username
        ]
    }
    
    private func getChatUrl() -> String {
        return "\(self.chatUrl)?platform=\(self.platform)&registration_id=\(self.myUUID)&roomlist=1"
    }
    
    public func setChatWindows() -> Void {
        sendRequest(registerUrl, parameters: param)
    }
    
    private func sendRequest(url:String, parameters:[String:String]) -> Void {
        
        let authString = NSString(format: "%@:%@", clientappKey, self.password)
        let credentialData = authString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        //print("Basic \(base64Credentials)")
        
        let headers = ["Authorization":"Basic \(base64Credentials)"]
        
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: headers)
            .responseJSON { response in
            debugPrint(response)
                
                let json = JSON(response.result.value!)
                self.p_username = json["result"]["p_username"].stringValue
                print(self.p_username)
                self.chatUrl = json["result"]["chat_url"].stringValue
                print(self.chatUrl)
                
                self.param1 = [
                    "p_username":self.p_username,
                    "password":self.password,
                    "platform":self.platform,
                    "name":self.username
                ]
                
                if self.chatUrl == "" {
                    self.sendRequest(self.initializeUrl, parameters: self.param1)
                }else{
                    let chatUrl = NSURL(string:self.getChatUrl())
                    let requestUrl = NSURLRequest(URL: chatUrl!)
                    self.chatView.loadRequest(requestUrl)

                }
        }
    }
    
}

