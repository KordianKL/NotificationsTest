//
//  MainViewController.swift
//  ios-internship-notifications
//
//  Created by Kordian Ledzion on 17/10/2017.
//  Copyright © 2017 Tooploox Sp. z o.o. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let datePickerView = UIDatePicker()
    private let confirmationButton = UIButton(type: UIButtonType.system)
    private let notificationsGateway = NotificationsGateway()

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsGateway.requestPermissions()
        setUpMainView()
        setUpDatePickerView()
        setUpConfirmationButton()
        setUpConstraints()
    }
    
    private func setUpMainView() {
        view.backgroundColor = .white
    }
    
    private func setUpDatePickerView() {
        datePickerView.minimumDate = Date()
        datePickerView.datePickerMode = .dateAndTime
    }
    
    private func setUpConfirmationButton() {
        confirmationButton.setTitle("Remind me", for: .normal)
        confirmationButton.setTitleColor(.darkGray, for: .normal)
        confirmationButton.layer.cornerRadius = 12.5
        confirmationButton.layer.borderWidth = 0.5
        confirmationButton.layer.borderColor = UIColor.lightGray.cgColor
        confirmationButton.addTarget(self, action: #selector(confirmReminder), for: .touchUpInside)
    }
    
    private func setUpConstraints() {
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePickerView)
        NSLayoutConstraint.activate([
            datePickerView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: 20.0),
            datePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            datePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0)
        ])
        
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confirmationButton)
        NSLayoutConstraint.activate([
            confirmationButton.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 15.0),
            confirmationButton.widthAnchor.constraint(equalToConstant: 184.0),
            confirmationButton.heightAnchor.constraint(equalToConstant: 68.0),
            confirmationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func confirmReminder() {
        guard datePickerView.date.compare(Date()) != .orderedAscending else {
            let vc = UIAlertController(title: "Opps!", message: "You must schedule the reminder for FUTURE you dummy!", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Okay, sorry >:-]", style: .cancel, handler: nil))
            present(vc, animated: true, completion: nil)
            return
        }
        
        let time = datePickerView.date.timeIntervalSinceNow
        
        notificationsGateway.scheduleNotification(in: time, completion: { [unowned self] didSchedule in
            let vc = UIAlertController(title: "Done!", message: didSchedule ? "Notification scheduled!" : "Couldn't schedule notification :(", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(vc, animated: true, completion: nil)
        })
    }

}
