//
//  NotificationRespondViewController.swift
//  ios-internship-notifications
//
//  Created by Kordian Ledzion on 18/10/2017.
//  Copyright © 2017 Tooploox Sp. z o.o. All rights reserved.
//

import UIKit

class NotificationRespondViewController: UIViewController {
    
    private let messageLabel = UILabel()
    private let goBackButton = UIButton(type: .system)
    private let viewModel: NotificationRespondViewModel
    
    init(viewModel: NotificationRespondViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainView()
        setUpMessageLabel()
        setUpGoBackButton()
        setUpConstraints()
    }
    
    private func setUpMainView() {
        view.backgroundColor = .white
    }
    
    private func setUpMessageLabel() {
        messageLabel.text = viewModel.messageLabelText
        messageLabel.textAlignment = .center
    }
    
    private func setUpGoBackButton() {
        goBackButton.setTitle("Go back!", for: .normal)
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    private func setUpConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.heightAnchor.constraint(equalToConstant: 96.0),
            messageLabel.widthAnchor.constraint(equalToConstant: 192.0),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goBackButton)
        NSLayoutConstraint.activate([
            goBackButton.heightAnchor.constraint(equalToConstant: 48.0),
            goBackButton.widthAnchor.constraint(equalToConstant: 96.0),
            goBackButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor),
            goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func goBack() {
        self.dismiss(animated: true, completion: nil)
    }

}
