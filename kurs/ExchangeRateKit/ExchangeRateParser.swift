//
//  ExchangeRateParser.swift
//  kurs
//
//  Created by Sergey Yuryev on 17/01/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

import Foundation

let kURLString : String = "http://www.cbr.ru/scripts/XML_daily.asp"

public let kValCurs : String = "ValCurs"
public let kDate : String = "Date"
public let kID : String = "ID"
public let kValute : String = "Valute"
public let kNumCode : String = "NumCode"
public let kCharCode : String = "CharCode"
public let kNominal : String = "Nominal"
public let kName : String = "Name"
public let kValue : String = "Value"

public class ExchangeRateParser: NSObject, NSXMLParserDelegate {
    
    // MARK - vars
    
    var items : [Dictionary<String, String>] = []
    
    private var date : String = ""
    private var numCode : String = ""
    private var charCode : String = ""
    private var nominal : String = ""
    private var name : String = ""
    private var value : String = ""
    private var currentElement : String = ""

    // MARK - func
    
    public func getRates() -> [Dictionary<String, String>] {
        let url : NSURL = NSURL(string: kURLString)!
        
        if let parser = NSXMLParser(contentsOfURL: url) {
            parser.delegate = self
            parser.parse()
        }
        return items
    }
    
    // MARK - NSXMLParser delegate
    
    public func parserDidStartDocument(parser: NSXMLParser!) {
    }
    
    public func parserDidEndDocument(parser: NSXMLParser!) {
    }
    
    public func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        
        if let  attributes = attributeDict as? Dictionary<String, AnyObject> {
            if let  attributeDate = attributes[kDate] as? String {
                date = attributeDate
            }
        }
        
        if let element = elementName {
            currentElement = element
            
            if element == kValute {
                numCode  = ""
                charCode = ""
                nominal  = ""
                name     = ""
                value    = ""
            }
        }
    }
  public   
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        if currentElement == kNumCode {
            numCode = numCode + string.condenseWhitespace()
        }
        else if currentElement == kCharCode {
            charCode = charCode + string.condenseWhitespace()
        }
        else if currentElement == kNominal {
            nominal = nominal + string.condenseWhitespace()
        }
        else if currentElement == kName {
            name = name + string.condenseWhitespace()
        }
        else if currentElement == kValue {
            value = value + string.condenseWhitespace()
        }
    }
  public   
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if let element = elementName {
            if element == kValute {
                let item = [kNumCode:numCode, kCharCode:charCode, kNominal:nominal, kName:name, kValue:value, kDate: date]
                items.append(item)
            }
        }
    }
}
