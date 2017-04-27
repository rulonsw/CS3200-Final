//
//  SocialViewController.swift
//  Obsidian_Disc
//
//  Created by Rulon Wood on 4/26/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit
import MessageUI
import RealmSwift
import EventKit

class SocialViewController: UIViewController, MFMessageComposeViewControllerDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: Event Store Things
    let eventStore = EKEventStore()
    
    override func viewWillAppear(_ animated: Bool) {
        checkCalendarAuthorizationStatus()
    }
    
    func addEventToCalendar() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        if status == EKAuthorizationStatus.authorized {
            let calendarForEvent = eventStore.defaultCalendarForNewEvents
            let newEvent = EKEvent(eventStore: eventStore)
            
            newEvent.calendar = calendarForEvent
            newEvent.title = "Obsidian Disc Campaign Reminder"
            if (reminderText.text?.isEmpty)! {
                newEvent.notes = "Don't forget the dice!"
            } else { newEvent.notes = reminderText.text }
            newEvent.startDate = self.campaignDatePicker.date
            newEvent.endDate = self.campaignDatePicker.date.addingTimeInterval(3600)
            
            // Save the calendar using the Event Store instance
        
            do {
                try eventStore.save(newEvent, span: .thisEvent, commit: true)
                let alert = UIAlertController(title: "Event saved", message: ("Event was saved to calendar. Don't believe me? Go check!"), preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
            } catch {
                let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            let alert = UIAlertController(title: "Give the app permission to your calendar.", message: ("The app must be authorized to use your calendar before it may save reminders for you."), preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
        }
        
    }
    
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            print("Great job!")
            // Things are in line with being able to show the calendars in the table view
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            let alert = UIAlertController(title: "This Area Will Not Work", message: "In order to use this feature, calendar authorization must be granted.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Boo!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            
            if accessGranted == true {
                self.addEventToCalendar()
                
            } else {
                DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: "This Area Will Not Work", message: "In order to use this feature, calendar authorization must be granted.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Boo!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)                })
            }
        })
    }
    
    // MARK: Realm setup
    var contacts = List<Contact>()
    var notificationToken: NotificationToken!
    var realm: Realm!
    func setupRealm() {
        let username = "rulonsdangerwoodiv+cs3200@gmail.com"
        let password = "asdfasdf"
        
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://127.0.0.1:9080")!) { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            DispatchQueue.main.async {
                // Open Realm
                let configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://127.0.0.1:9080/~/obs-disc")!)
                )
                self.realm = try! Realm(configuration: configuration)
                
                // Show initial tasks
                func updateList() {
                    if self.contacts.realm == nil, let list = self.realm.objects(ContactList.self).first {
                        self.contacts = list.contacts
                    }
                    self.singleContactPicker.reloadAllComponents()
                }
                updateList()
                
                // Notify us when Realm changes
                self.notificationToken = self.realm.addNotificationBlock { _ in
                    updateList()
                }
            }
        }
    }
    deinit {
        notificationToken.stop()
    }
    
    
    var state = 0

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
    
//MARK: Contact Picker Setup
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        return contacts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let contactsSorted = contacts.sorted(byKeyPath: "name", ascending: true)
        return contactsSorted[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent: Int) {
        let contactsSorted = contacts.sorted(byKeyPath: "name", ascending: true)
        updateUneditablePhoneNumberField(contactName: contactsSorted[row].name)
    }

    
    @IBAction func submitAction(_ sender: Any) {
        if state == 0 {
            addEventToCalendar()
        }
        else if state == 1 {
            sendMessage(body: messageTextEntry.text, recipient: phoneNumberEntry.text!)
        }
        else {
            addContact()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRealm()
        
//MARK: Delegate/DataSource Settings
        messageTextEntry.delegate = self
        reminderText.delegate = self
        phoneNumberEntry.delegate = self
        singleContactPicker.delegate = self
        singleContactPicker.dataSource = self
        
        
//MARK: Keyboard defaults
        phoneNumberEntry.keyboardType = UIKeyboardType.numberPad
        
// Set campaign date
        if (state == 0) {
            backCancelButt.title = "<"
            campaignDatePicker.isHidden = false
            reminderText.isHidden = false
            messageTextEntry.isHidden = true
            phoneNumberEntry.isHidden = true
            singleContactPicker.isHidden = true
            welcomeLabel.text = "When will your next play session be?"
            self.title = "Campaign Date Selection"
            actionSubmitButt.setTitle("Set Reminder", for: UIControlState.normal)
        }
// Send player secret
        else if (state == 1) {
            phoneNumberEntry.isHidden = false
            phoneNumberEntry.isEnabled = false
            
            messageTextEntry.layer.borderWidth = 1
            messageTextEntry.layer.cornerRadius = 3
            messageTextEntry.layer.borderColor = UIColor.lightGray.cgColor
            messageTextEntry.isHidden = false
            
            reminderText.isHidden = true
            singleContactPicker.isHidden = false
            welcomeLabel.text = "Which contact will you reach out to?"
            self.title = "Share GM Secret"
        }
// Add player (contacts mgmt)
        else {
            phoneNumberEntry.isHidden = false
            reminderText.isHidden = false
            reminderText.placeholder = "Contact Name"
            backCancelButt.title = "Cancel"
            welcomeLabel.text = "Please enter the name and phone\nnumber of your new contact."
            actionSubmitButt.setTitle("Add Contact", for: UIControlState.normal)

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

// MARK: - Action definitions]
    func updateUneditablePhoneNumberField(contactName: String) {
        let phone = self.contacts.filter("name contains '" + contactName + "'").first?.phonenumber
        self.phoneNumberEntry.text = phone
    }
    func addContact() {
        guard let contactName = reminderText.text,
            let contactPhoneNumber = phoneNumberEntry.text,
            !contactName.isEmpty,
            !contactPhoneNumber.isEmpty else { return }
        let contacts = self.contacts
        try! contacts.realm?.write {
            contacts.append(Contact(value: ["name": contactName,"phonenumber": contactPhoneNumber]))
        }
    //Successful addition
        let alert = UIAlertController(title: "Contact Addition Successful", message: "Your player should now be present in your \"Send Player Secret\" contact picker.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Great!", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //Note: I have no idea if this actually works because I don't own an actual iPhone to test it on.
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
