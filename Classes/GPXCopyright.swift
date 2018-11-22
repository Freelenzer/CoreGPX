//
//  GPXCopyright.swift
//  GPXKit
//
//  Created by Vincent on 22/11/18.
//

import UIKit

class GPXCopyright: GPXElement {
    var yearValue = String()
    
    //var year:NSDate?
    var license:String?
    var author:String?
    
    // MARK:- Instance
    
    override init() {
        super.init()
    }
    
    override init(XMLElement element: UnsafeMutablePointer<TBXMLElement>?, parent: GPXElement?) {
        super.init(XMLElement: element, parent: parent)
        yearValue = self.text(forSingleChildElement: "year", xmlElement: element)
        license = self.text(forSingleChildElement: "license", xmlElement: element)
        author = self.text(forSingleChildElement: "author", xmlElement: element, required: true)
    }
    
    func copyright(with author: String) -> GPXCopyright {
        let copyright = GPXCopyright()
        copyright.author = author
        
        return copyright
    }
    
    // MARK:- Public Methods
    
    var year: Date? {
        return GPXType().dateTime(value: yearValue)
    }
    
    func set(year: Date) {
        yearValue = GPXType().value(forDateTime: year)
    }
    
    // MARK: Tag
    
    override func tagName() -> String! {
        return "copyright"
    }
    
    // MARK: GPX
    
    override func addOpenTag(toGPX gpx: NSMutableString, indentationLevel: Int) {
        let attribute: NSMutableString = ""
        
        if author != nil {
            attribute.appendFormat(" author=\"%@\"", author!)
        }
        
        gpx.appendFormat("%@<%@%@>\r\n", tagName())
    }
    
    override func addChildTag(toGPX gpx: NSMutableString, indentationLevel: Int) {
        super.addChildTag(toGPX: gpx, indentationLevel: indentationLevel)
        self.addProperty(forValue: yearValue, gpx: gpx, tagName: "year", indentationLevel: indentationLevel)
        self.addProperty(forValue: license, gpx: gpx, tagName: "license", indentationLevel: indentationLevel)
    }
}
