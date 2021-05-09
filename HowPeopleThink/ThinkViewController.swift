//
//  ViewController.swift
//  HowPeopleThink
//
//  Created by youngjun kim on 2021/05/09.
//

import UIKit
import CoreML
import SwifteriOS
import SwiftyJSON

class ThinkViewController: UIViewController {

    @IBOutlet var thinkEmoji: UILabel!
    @IBOutlet var myTextField: UITextField!
    
    
    let peopleThinkModel = HowPeopleThink()
    
    let swifter = Swifter(consumerKey: "cfvKXyVEVYqwB4XE6XVtnPzuY", consumerSecret: "no1iTCLd3sAtbAQ3kQU80FsAPHsVPiITVcAgu8UcKO68psCgQo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func predictButtonPressed(_ sender: UIButton) {
        if let object = myTextField.text {
            
            swifter.searchTweet(using: object, lang: "en", count: 100, tweetMode: .extended) { (results, error) in
                
                var peopleThinkArray = [HowPeopleThinkInput]()
                
                for i in 0..<100 {
                    if let text = results[i]["full_text"].string {
                        
                        let peopleThinkText = HowPeopleThinkInput(text: text)
                        peopleThinkArray.append(peopleThinkText)
                    }
                }
                
                do {
                    let prediction = try self.peopleThinkModel.predictions(inputs: peopleThinkArray)
                    
                    var score = 0
                    
                    for pred in prediction {
                        if pred.label == "Pos" {
                            score += 1
                        } else if pred.label == "Neg" {
                            score -= 1
                        }
                    }
                    
                    if score > 20 {
                        self.thinkEmoji.text = "😍 \(score)"
                        self.thinkEmoji.textColor = UIColor.green
                    } else if score > 10 {
                        self.thinkEmoji.text = "😄 \(score)"
                        self.thinkEmoji.textColor = UIColor.green
                    } else if score > 0 {
                        self.thinkEmoji.text = "☺️ \(score)"
                        self.thinkEmoji.textColor = UIColor.black
                    } else if score == 0 {
                        self.thinkEmoji.text = "😐 \(score)"
                        self.thinkEmoji.textColor = UIColor.black
                    } else if score > -10 {
                        self.thinkEmoji.text = "😕 \(score)"
                        self.thinkEmoji.textColor = UIColor.black
                    } else if score > -20 {
                        self.thinkEmoji.text = "😡 \(score)"
                        self.thinkEmoji.textColor = UIColor.red
                    } else {
                        self.thinkEmoji.text = "🤮 \(score)"
                        self.thinkEmoji.textColor = UIColor.red
                    }
                    
                } catch {
                    print("Fail to fetch Tweet: \(error)")
                }
                
                
                
            } failure: { (Error) in
                print("Tweet search failed: \(Error)")
            }
        }
    }
    
}

