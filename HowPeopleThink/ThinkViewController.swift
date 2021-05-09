//
//  ViewController.swift
//  HowPeopleThink
//
//  Created by youngjun kim on 2021/05/09.
//

import UIKit
import CoreML
import SwifteriOS

class ThinkViewController: UIViewController {

    @IBOutlet var thinkEmoji: UILabel!
    @IBOutlet var myTextField: UITextField!
    
    
    let peopleThinkModel = HowPeopleThink()
    
    let swifter = Swifter(consumerKey: "cfvKXyVEVYqwB4XE6XVtnPzuY", consumerSecret: "no1iTCLd3sAtbAQ3kQU80FsAPHsVPiITVcAgu8UcKO68psCgQo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@apple", lang: "en", count: 100, tweetMode: .extended) { (results, error) in
            print(results)
        } failure: { (Error) in
            print("Tweet search failed: \(Error)")
        }

        
    }

    @IBAction func predictButtonPressed(_ sender: UIButton) {
    }
    
}

