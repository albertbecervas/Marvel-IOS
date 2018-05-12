//
//  model.swift
//  PicturesFromMars
//
//  Created by Albert Becerra Hervás on 01/05/2018.
//  Copyright © 2018 Albert Becerra Hervás. All rights reserved.
//

import Foundation

class Hero {
    
    //    var comicsList: [Comic] = [Comic]()
    //    var eventList: [Event] = [Event]()
    
    var id: String
    var name: String
    var description: String
    var imageUrl: String
    
    init(id: String, name: String, description: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
    }
    
    
    //    init(id: String, name: String, description: String, imageUrl: String, comicsList: [Comic], eventList: [Event]) {
    //        self.id = id
    //        self.name = name
    //        self.description = description
    //        self.imageUrl = imageUrl
    //        self.comicsList = comicsList
    //        self.eventList = eventList
    //    }
    
}
