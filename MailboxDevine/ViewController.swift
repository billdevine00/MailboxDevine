//
//  ViewController.swift
//  MailboxDevine
//
//  Created by WilliamDevine on 9/27/14.
//  Copyright (c) 2014 WilliamDevine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!

    var imageCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(320,2080)
        self.msgView.backgroundColor = UIColor.grayColor()
        laterIcon.alpha = 0
        deleteIcon.alpha = 0
        archiveIcon.alpha = 0
        listIcon.alpha = 0
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onPanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.translationInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            println("pan began")
            
            imageCenter = messageImageView.center
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("pan changed")
            println(messageImageView.center.x)

            messageImageView.center.x = translation.x + imageCenter.x
            // SWIPE LEFT. Turning the background yellow and showing the later icon
            
            if (messageImageView.center.x <= 100) {
                println("omg1")
                laterIcon.alpha = 1
                listIcon.alpha = 0

                msgView.backgroundColor = UIColor.yellowColor()
            }
            //SWIPE LEFT. Turning the background brown and showing the later icon
            if (messageImageView.center.x <= 0) {
                println("omg2")
                laterIcon.alpha = 0
                listIcon.alpha = 1
                msgView.backgroundColor = UIColor.brownColor()
            }
            // SWIPE RIGHT. Turning the background Green and showing delete icon
            
            if (messageImageView.center.x >= 220) {
                println("omg3")
                archiveIcon.alpha = 1
                deleteIcon.alpha = 0
                msgView.backgroundColor = UIColor.greenColor()

            }
            // SWIPE RIGHT. Turning the background Red and showing delete icon

            if (messageImageView.center.x >= 320) {
                println("omg3")
                archiveIcon.alpha = 0
                deleteIcon.alpha = 1
                msgView.backgroundColor = UIColor.redColor()
                
            }
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended{
            println("pan ended")
            msgView.backgroundColor = UIColor.grayColor()
            
            UIView.animateWithDuration(0.2, animations: {() -> Void in
                
                if self.messageImageView.center.x >= 220 && self.messageImageView.center.x <= 319 {
                    println("center is between 220 and 319")
                    self.performSegueWithIdentifier("rescheduleSegue", sender: self)
                }
                
                if self.messageImageView.center.x >= 320  {
                    println("center is past 320")
                    self.messageImageView.center.x = 640
                    self.msgView.backgroundColor = UIColor.redColor()
                    self.msgView.alpha = 0
                    self.feedImage.frame.origin.y = 144
                    
                    
                }
//
//                if velocity.x < 220  {
//                    self.messageImageView.center.x = 160
//                    
//                }
//                
//                if velocity.x < 100  {
//                    self.messageImageView.center.x = 160
//                    
//                }
                
                
                })
    }
}
}
