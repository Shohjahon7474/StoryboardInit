//
//  EditViewController.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 03/11/21.
//

import UIKit

class EditViewController: BaseViewController, EditView {
    
    
    @IBOutlet weak var bodyTextView: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var ContactID: String = "1"
    var contact : Contact = Contact(name: "name", number: "number")
    var presenter: EditPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = EditPresenter()
        presenter.editView = self
        presenter.controller = self
        presenter?.apiCallContact(id: Int(ContactID)!)
    }

    
    @IBAction func buttonPressed(_ sender: Any) {
        presenter?.apiEditContact(id: Int(ContactID)!, contact: Contact(name: titleTextField.text!, number: bodyTextView.text!))

    }
    
    
    
    func initViews(){
        bodyLabel.text = "Name"
        titleLabel.text = "Number"
        DispatchQueue.main.async {
            self.bodyTextView.text = self.contact.number!
            self.titleTextField.text = self.contact.name!
        }
        
    }
    
    func onCallContact(contact: Contact) {
        if contact != nil {
            self.contact = contact
            initViews()
        }else{
            // error message
        }
    }
    
    func onEditContact(status: Bool) {
        if status{
            self.dismiss(animated: false, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }else{
            // error message
        }
        
    }
    
    
    
}
