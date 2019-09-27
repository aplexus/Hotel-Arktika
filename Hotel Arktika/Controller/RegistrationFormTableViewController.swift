//
//  RegistrationFormTableViewController.swift
//  Hotel Arktika
//
//  Created by Aleksey Popov on 25/09/2019.
//  Copyright © 2019 Aleksey Popov. All rights reserved.
//

import UIKit

class RegistrationFormTableViewController: UITableViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var chekInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdults: UIStepper!
    @IBOutlet weak var numberOfChildrens: UIStepper!
    @IBOutlet weak var countOfAdults: UILabel!
    @IBOutlet weak var countOfChildrensLabel: UILabel!
    let checkInDatePickerIndexPath = IndexPath (row: 1, section: 1)
    let checkOutDatePickerIndexPath = IndexPath (row: 3, section: 1)
    var priceForWifi = 0
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            chekInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerIsShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerIsShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnight = Calendar.current.startOfDay(for: Date())
        chekInDatePicker.minimumDate = midnight
        chekInDatePicker.date = midnight
        updateDateViews()
    }
    
    func updateDateViews () {
        checkOutDatePicker.minimumDate = chekInDatePicker.date.addingTimeInterval(60*60*24)
        
        let dateFormatter = DateFormatter ()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: chekInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
        
    }
    
    @IBAction func DoneBarButtonTapped(_ sender: Any) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = chekInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfadults = countOfAdults.text ?? ""
        let numberOfChildrens = countOfChildrensLabel.text ?? ""
        
        
        print ("First Name:", firstName)
        print ("Last Name:", lastName)
        print ("E-mail:", email)
        print ("Check-In:", checkInDate)
        print ("Check-Out:", checkOutDate)
        print ("Количество взрослых:", numberOfadults)
        print ("Количество детей:", numberOfChildrens)
        updateWifi ()
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    
    @IBAction func StepperOfAdults(_ sender: Any) {
        countOfAdults.text = String (Int(numberOfAdults.value))
    }
    @IBAction func stepperOfChildrens(_ sender: UIStepper) {
        countOfChildrensLabel.text = String( Int(numberOfChildrens.value))
    }
    
    @IBAction func switchOfWifi(_ sender: UISwitch) {
        if (sender.isOn == true) {
            priceForWifi = 10
        } else {
            priceForWifi = 0
    }
    }
    func updateWifi (){
        if priceForWifi == 10 {
            print ("Стоимость за wifi составляет: \(priceForWifi) $")
    }
    }
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath:
            if isCheckInDatePickerShown {
                return 216
            } else {
                return 0
            }
        case checkOutDatePickerIndexPath:
            if isCheckOutDatePickerIsShown {
                return 216
            } else {
                return 0
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section == checkInDatePickerIndexPath.section || indexPath.section == checkOutDatePickerIndexPath.section else {return}
        
        switch indexPath.row {
        case checkInDatePickerIndexPath.row - 1:
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerIsShown {
                isCheckOutDatePickerIsShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        case checkOutDatePickerIndexPath.row - 1:
            if isCheckOutDatePickerIsShown {
                isCheckOutDatePickerIsShown = false
            } else if isCheckInDatePickerShown{
                isCheckInDatePickerShown = false
                isCheckOutDatePickerIsShown = true
            }
            else {
                isCheckOutDatePickerIsShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
        
    }
    
    
}
