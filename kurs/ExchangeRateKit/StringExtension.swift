//
//  StringExtenstion.swift
//  kurs
//
//  Created by Sergey Yuryev on 20/01/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

import Foundation

extension String {
    func condenseWhitespace() -> String {
        let components = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({!Swift.isEmpty($0)})
        return " ".join(components)
    }
}