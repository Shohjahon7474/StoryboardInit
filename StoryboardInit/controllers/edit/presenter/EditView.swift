//
//  EditView.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 06/11/21.
//

import Foundation

protocol EditView{
    func initViews()
    func onCallContact(contact: Contact)
    func onEditContact(status: Bool)
}
