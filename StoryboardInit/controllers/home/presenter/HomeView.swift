//
//  HomeView.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 06/11/21.
//

import Foundation

protocol HomeView{
    func onLoadContacts(contacts: [Contact])
    func onContactDelete(deleted: Bool)
}
