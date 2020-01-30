//
//  Section.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

struct Section {
    
    var title: String!
    var subtitle: String!
    var content: [String]!
    var isExpanded: Bool!
    
    init(title: String, subtitle: String, content: [String], isExpanded: Bool) {
        self.title = title
        self.subtitle = subtitle
        self.isExpanded = isExpanded
        self.content = content
    }
}














































