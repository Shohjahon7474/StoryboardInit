//
//  CreateViewController.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 03/11/21.
//

import UIKit

class CreateViewController: BaseViewController, CreateView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextField!
    
    var presenter: CreatePresenter!
    var item = Contact(name: "name", number: "number")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    func initViews(){
        presenter = CreatePresenter()
        presenter.createView = self
        presenter.controller = self
        titleLabel.text = "Name"
        bodyLabel.text = "Number"

        let add = UIImage(systemName: "paperplane")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
    }

    @objc func rightTapped(){
        if titleField.text != "" && bodyTextView.text != "" {
            presenter?.apiCreateContact(contact: Contact(name: titleField.text!, number: bodyTextView.text!))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    func onCreated(status: Bool) {
        if status {
            self.navigationController?.popViewController(animated: true)
        }else{
            // something went wrong! 😐
        }
        
    }
    
}
