//
//  KursFeedHelper.swift
//  kurs
//
//  Created by Sergey Yuryev on 16/01/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

import UIKit

class KursFeedHelper: NSObject {
    
    var url : NSURL
//    var items : Array
    
    init(url: NSURL) {
        self.url = url
    }
    
    //    <ValCurs Date="15.01.2015" name="Foreign Currency Market">
    //    <Valute ID="R01010">
    //    <NumCode>036</NumCode>
    //    <CharCode>AUD</CharCode>
    //    <Nominal>1</Nominal>
    //    <Name>Австралийский доллар</Name>
    //    <Value>53,6652</Value>
    //    </Valute>
    
    
    var max = {
        (num1:Int,num2:Int) ->  Int in
        
        let parser = NSXMLParser(contentsOfURL: self.url)
        
        parser?.delegate = self
        
        parser?.parse()
        
        return num1 > num2 ? num1 : num2
    }
    
    // MARK - Parsing
    
    func parserDidStartDocument(parser: NSXMLParser!) {
        println("Start parsing")
    }
    
    func parserDidEndDocument(parser: NSXMLParser!) {
        println("End parsing")
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        println("Start element", elementName)
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        println("End element", elementName)
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        println("Found char ", string)
    }
}
