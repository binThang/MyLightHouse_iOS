//
//  SectionForProgramInfo.swift
//  LeanOnMe
//
//  Created by Justin Ji on 01/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

struct SectionForProgramInfo {
    
    var title: String!
    var content: [String]!
    var isExpanded: Bool!
    
    init(title: String, content: [String]?, isExpanded: Bool?) {
        self.title = title
        self.isExpanded = isExpanded
        self.content = content
    }
}
