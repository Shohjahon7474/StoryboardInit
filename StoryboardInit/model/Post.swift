//
//  Post.swift
//  StoryboardContacts
//
//  Created by Shohjahon Numonovich on 6/14/22.
//

import Foundation

struct Post: Decodable{
    var id: String? = ""
    var name: String? = ""
    var number: String? = ""
    
    init(name:String, number:String){
        self.name = name
        self.number = number
    }
}
