//
//  EditPresenter.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 06/11/21.
//

import Foundation

protocol EditPresenterProtocol {
    func apiCallContact(id: Int)
    func apiEditContact(id: Int, contact: Contact)
}

class EditPresenter: EditPresenterProtocol{
    var editView : EditView!
    var controller: BaseViewController!
    
    func apiCallContact(id: Int){
        controller?.showProgress()
        AFHttp.get(url: AFHttp.API_CONTACT_SINGLE + String(id), params: AFHttp.paramsContactWith(id: id), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                let decode = try! JSONDecoder().decode(Contact.self, from: response.data!)
                self.editView.onCallContact(contact: decode)
            case let .failure(error):
                print(error)
                self.editView.onCallContact(contact: Contact(name: "name", number: "number"))
            }
        })
    }
   
    func apiEditContact(id: Int, contact: Contact) {
        controller?.showProgress()
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + String(id), params: AFHttp.paramsContactUpdate(contact: contact)) { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print("SUCCESS")
                self.editView.onEditContact(status: true)
            case let .failure(error):
                print(error)
                self.editView.onEditContact(status: false)
            }
        }
    }
}
