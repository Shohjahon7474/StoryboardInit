//
//  CreatePresenter.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 06/11/21.
//

import Foundation

protocol CreatePresenterProtocol{
    func apiCreateContact(contact: Contact)
}

class CreatePresenter : CreatePresenterProtocol{
    
    var createView: CreateView!
    var controller: BaseViewController!
    
    func apiCreateContact(contact: Contact){
        self.controller?.showProgress()
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact)) { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print("SUCCESS")
                self.createView.onCreated(status: true)
            case let .failure(error):
                print(error)
                self.createView.onCreated(status: false)
            }
        }
    }
    
    
}
