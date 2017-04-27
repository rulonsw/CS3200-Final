//
//  SocialViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/26/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit
import MessageUI

class SocialViewController: UIViewController, MFMessageComposeViewControllerDelegate, UITextViewDelegate {
    
    var state = 0

    @IBOutlet weak var addContactButt: UIBarButtonItem!
    @IBOutlet weak var backCancelButt: UIBarButtonItem!
    
    @IBOutlet weak var reminderText: UITextField!
    
    @IBOutlet weak var phoneNumberEntry: UITextField!
    @IBOutlet weak var messageTextEntry: UITextView!
    
    @IBOutlet weak var campaignDatePicker: UIDatePicker!
    @IBOutlet weak var actionSubmitButt: UIButton!
    @IBOutlet weak var singleContactPicker: UIPickerView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // MARK: Making my own textview placeholder text
    //Since textviews don't have placeholders...
    func textViewDidBeginEditing(_ tv: UITextView) {
        if tv.textColor == UIColor.lightGray {
            tv.text = ""
            tv.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ tv: UITextView) {
        if tv.text.isEmpty {
            tv.text = "Enter Message Here..."
            tv.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func submitAction(_ sender: Any) {
        if (state == 1) {
            sendMessage(body: messageTextEntry.text, recipient: phoneNumberEntry.text!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextEntry.delegate = self
        reminderText.delegate = self
        phoneNumberEntry.delegate = self
        phoneNumberEntry.keyboardType = UIKeyboardType.numberPad
        
        if (state == 0) {
            backCancelButt.title = "<"
            addContactButt.isEnabled = false
            addContactButt.title = ""
            campaignDatePicker.isHidden = false
            reminderText.isHidden = false
            messageTextEntry.isHidden = true
            phoneNumberEntry.isHidden = true
            singleContactPicker.isHidden = true
            welcomeLabel.text = "When will your next play session be?"
            self.title = "Campaign Date Selection"
            actionSubmitButt.setTitle("Set Reminder", for: UIControlState.normal)
        }
        else if (state == 1) {
            backCancelButt.title = "<"
            addContactButt.title = ""
            addContactButt.isEnabled = false
            
            phoneNumberEntry.isHidden = false
            messageTextEntry.isHidden = false
            reminderText.isHidden = true
            singleContactPicker.isHidden = false
            welcomeLabel.text = "Which contact will you reach out to?"
            self.title = "Share GM Secret"
        }
        else {
            addContactButt.isEnabled = true
            phoneNumberEntry.isHidden = false
            reminderText.isHidden = false
            reminderText.placeholder = "Contact Name"
            addContactButt.title = "+"
            backCancelButt.title = "Cancel"
            welcomeLabel.text = "Please enter the name and phone\nnumber of your new contact."
            actionSubmitButt.setTitle("Add Contact", for: UIControlState.normal)

        }
        campaignDatePicker.date.description
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    
    // MARK: - Messaging
    
    //Note: I have no idea if this actually works because I don't own an iPhone to test it on.
    //However, I am semi-confident this will do what it's supposed to on an actual device.
    
    func sendMessage(body: String, recipient: String) {
        if !MFMessageComposeViewController.canSendText() {
            let alert = UIAlertController(title: "Do you think this is a game?", message: "Text messages can't be sent through the Simulator.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Fine", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            var recips = [String()]
            recips.append(recipient)
            let messageVC = MFMessageComposeViewController()
            messageVC.body = body
            messageVC.recipients = recips // Optionally add some tel numbers
            messageVC.messageComposeDelegate = self
            present(messageVC, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue:
            print("message canceled")
     
            case MessageComposeResult.failed.rawValue:
                print("message failed")
     
            case MessageComposeResult.sent.rawValue :
                print("message sent")
     
            default:
                break
            }
            controller.dismiss(animated: true, completion: nil)
    }
}

extension SocialViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }}
