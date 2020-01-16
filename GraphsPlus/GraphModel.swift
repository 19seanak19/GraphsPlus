//
//  GraphModel.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/21/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import Foundation

struct KeyAndLineGraphData: Codable {
     var key: String
     var data: LineGraphData
}
struct KeyAndBarGraphData: Codable {
    var key: String
    var data: BarGraphData
}
struct KeyAndGraphStyle: Codable {
    var key: String
    var style: GraphStyle
}
struct KeyAndLineStyle: Codable {
    var key: String
    var style: LineStyle
}
struct KeyAndBarStyle: Codable {
    var key: String
    var style: BarStyle
}

class GraphModel {
    
    // MARK: - Shared Instance
    
    static let shared = GraphModel()
    
    fileprivate init() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let lineGraphsFilename = "GraphsPlus_LineGraphs"
        lineGraphsURL = documentsURL.appendingPathComponent(lineGraphsFilename + ".archive")
        
        lineGraphs = [:]
        
        let lineGraphsFileExists = fileManager.fileExists(atPath: lineGraphsURL.path)
        if lineGraphsFileExists {
            do {
                let data = try Data(contentsOf: lineGraphsURL)
                let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
                if let _lineGraphs = unarchiver.decodeDecodable([KeyAndLineGraphData].self, forKey: NSKeyedArchiveRootObjectKey) {
                    for keyAndData in _lineGraphs {
                        lineGraphs[keyAndData.key] = keyAndData.data
                    }
                }
            } catch {
                print(error)
            }
        }
        
        let barGraphsFilename = "GraphsPlus_BarGraphs"
        barGraphsURL = documentsURL.appendingPathComponent(barGraphsFilename + ".archive")
        
        barGraphs = [:]
        
        let barGraphsFileExists = fileManager.fileExists(atPath: barGraphsURL.path)
        if barGraphsFileExists {
            do {
                let data = try Data(contentsOf: barGraphsURL)
                let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
                if let _barGraphs = unarchiver.decodeDecodable([KeyAndBarGraphData].self, forKey: NSKeyedArchiveRootObjectKey) {
                    for keyAndData in _barGraphs {
                        barGraphs[keyAndData.key] = keyAndData.data
                    }
                }
            } catch {
                print(error)
            }
        }
        
        let graphStylesFilename = "GraphsPlus_GraphStyles"
        graphStylesURL = documentsURL.appendingPathComponent(graphStylesFilename + ".archive")
        
        graphStyles = ["Default" : GraphStyle()]
        
        let graphStylesFileExists = fileManager.fileExists(atPath: graphStylesURL.path)
        if graphStylesFileExists {
            do {
                let data = try Data(contentsOf: graphStylesURL)
                let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
                if let _graphStyles = unarchiver.decodeDecodable([KeyAndGraphStyle].self, forKey: NSKeyedArchiveRootObjectKey) {
                    for keyAndStyle in _graphStyles {
                        graphStyles[keyAndStyle.key] = keyAndStyle.style
                    }
                }
            } catch {
                print(error)
            }
        }
        
        let lineStylesFilename = "GraphsPlus_LineStyles"
        lineStylesURL = documentsURL.appendingPathComponent(lineStylesFilename + ".archive")
        
        lineStyles = ["Default" : LineStyle()]
        
        let lineStylesFileExists = fileManager.fileExists(atPath: lineStylesURL.path)
        if lineStylesFileExists {
            do {
                let data = try Data(contentsOf: lineStylesURL)
                let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
                if let _lineStyles = unarchiver.decodeDecodable([KeyAndLineStyle].self, forKey: NSKeyedArchiveRootObjectKey) {
                    for keyAndStyle in _lineStyles {
                        lineStyles[keyAndStyle.key] = keyAndStyle.style
                    }
                }
            } catch {
                print(error)
            }
        }
        
        let barStylesFilename = "GraphsPlus_BarStyles"
        barStylesURL = documentsURL.appendingPathComponent(barStylesFilename + ".archive")
        
        barStyles = ["Default" : BarStyle()]
        
        let barStylesFileExists = fileManager.fileExists(atPath: barStylesURL.path)
        if barStylesFileExists {
            do {
                let data = try Data(contentsOf: barStylesURL)
                let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
                if let _barStyles = unarchiver.decodeDecodable([KeyAndBarStyle].self, forKey: NSKeyedArchiveRootObjectKey) {
                    for keyAndStyle in _barStyles {
                        barStyles[keyAndStyle.key] = keyAndStyle.style
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    // MARK: - Public Members
    
    // MARK: Line Graphs
    
    public var currentLineGraphData = LineGraphData()
    
    public func addCurrentLineGraph() {
        let graphKey = (currentLineGraphData.graphTitle != nil) ? currentLineGraphData.graphTitle! : getNextAvailableLineGraphKey()
        lineGraphs[graphKey] = currentLineGraphData
        saveLineGraphs()
    }
    
    public func updateLineGraph(withKey key: String) {
        var graphKey = key
        
        if let graphTitle = currentLineGraphData.graphTitle {
            lineGraphs[key] = nil
            graphKey = graphTitle
        }
        
        lineGraphs[graphKey] = currentLineGraphData
        saveLineGraphs()
    }
    
    public func getSavedLineGraphCount() -> Int {
        return lineGraphs.count
    }
    
    public func getSavedLineGraph(atIndexPath indexPath: IndexPath) -> KeyAndLineGraphData {
        if lineGraphsArray.indices.contains(indexPath.row) {
            return lineGraphsArray[indexPath.row]
        }
        
        return KeyAndLineGraphData(key: "Default Line Graph", data: LineGraphData())
    }
    
    public func removeSavedLineGraph(atIndexPath indexPath: IndexPath) {
        if lineGraphsArray.indices.contains(indexPath.row) {
            let savedLineGraphToRemove = lineGraphsArray[indexPath.row]
            
            lineGraphs[savedLineGraphToRemove.key] = nil
            saveLineGraphs()
        }
    }
    
    // MARK: Bar Graphs
    
    public var currentBarGraphData = BarGraphData()
    
    public func addCurrentBarGraph() {
        let graphKey = (currentBarGraphData.graphTitle != nil) ? currentBarGraphData.graphTitle! : getNextAvailableBarGraphKey()
        barGraphs[graphKey] = currentBarGraphData
        saveBarGraphs()
    }
    
    public func updateBarGraph(withKey key: String) {
        var graphKey = key
        
        if let graphTitle = currentLineGraphData.graphTitle {
            barGraphs[key] = nil
            graphKey = graphTitle
        }
        
        barGraphs[graphKey] = currentBarGraphData
        saveBarGraphs()
    }
    
    public func getSavedBarGraphCount() -> Int {
        return barGraphs.count
    }
    
    public func getSavedBarGraph(atIndexPath indexPath: IndexPath) -> KeyAndBarGraphData {
        if barGraphsArray.indices.contains(indexPath.row) {
            return barGraphsArray[indexPath.row]
        }
        
        return KeyAndBarGraphData(key: "Default Bar Graph", data: BarGraphData())
    }
    
    public func removeSavedBarGraph(atIndexPath indexPath: IndexPath) {
        if barGraphsArray.indices.contains(indexPath.row) {
            let savedBarGraphToRemove = barGraphsArray[indexPath.row]
            
            barGraphs[savedBarGraphToRemove.key] = nil
            saveBarGraphs()
        }
    }
    
    // MARK: Graph Style
    
    public func addGraphStyle(_ style: GraphStyle) {
        graphStyles[style.name] = style
        saveGraphStyles()
    }
    
    public func getGraphStyle(named styleName: String) -> GraphStyle {
        if let style = graphStyles[styleName] {
            return style
        }
        return GraphStyle()
    }
    
    public func checkForGraphStyle(named styleName: String) -> Bool {
        return graphStyles[styleName] != nil
    }
    
    // MARK: Line Style
    
    public func addLineStyle(_ style: LineStyle) {
        lineStyles[style.name] = style
        saveLineStyles()
    }
    
    public func getLineStyle(named styleName: String) -> LineStyle {
        if let style = lineStyles[styleName] {
            return style
        }
        return LineStyle()
    }
    
    public func checkForLineStyle(named styleName: String) -> Bool {
        return lineStyles[styleName] != nil
    }
    
    // MARK: Bar Style
    
    public func addBarStyle(_ style: BarStyle) {
        barStyles[style.name] = style
        saveBarStyles()
    }
    
    public func getBarStyle(named styleName: String) -> BarStyle {
        if let style = barStyles[styleName] {
            return style
        }
        return BarStyle()
    }
    
    public func checkForBarStyle(named styleName: String) -> Bool {
        return barStyles[styleName] != nil
    }
    
    // MARK: - Private Members
    
    private var lineGraphs: [String : LineGraphData]
    private var lineGraphsArray: [KeyAndLineGraphData] {
        get {
            var _lineGraphsArray: [KeyAndLineGraphData] = []
            
            let lineGraphKeys = lineGraphs.keys.sorted()
            for key in lineGraphKeys {
                if let matchingGraph = lineGraphs[key] {
                    _lineGraphsArray.append(KeyAndLineGraphData(key: key, data: matchingGraph))
                }
            }
            
            return _lineGraphsArray
        }
    }
    
    private var barGraphs: [String : BarGraphData]
    private var barGraphsArray: [KeyAndBarGraphData] {
        get {
            var _barGraphsArray: [KeyAndBarGraphData] = []
            
            let barGraphKeys = barGraphs.keys.sorted()
            for key in barGraphKeys {
                if let matchingGraph = barGraphs[key] {
                    _barGraphsArray.append(KeyAndBarGraphData(key: key, data: matchingGraph))
                }
            }
            
            return _barGraphsArray
        }
    }
    
    private var graphStyles: [String : GraphStyle]
    private var graphStylesArray: [KeyAndGraphStyle] {
        get {
            var _graphStylesArray: [KeyAndGraphStyle] = []
            
            let graphStyleKeys = graphStyles.keys.sorted()
            for key in graphStyleKeys {
                if let matchingStyle = graphStyles[key] {
                    _graphStylesArray.append(KeyAndGraphStyle(key: key, style: matchingStyle))
                }
            }
            
            return _graphStylesArray
        }
    }
    
    private var lineStyles: [String : LineStyle]
    private var lineStylesArray: [KeyAndLineStyle] {
        get {
            var _lineStylesArray: [KeyAndLineStyle] = []
            
            let lineStyleKeys = lineStyles.keys.sorted()
            for key in lineStyleKeys {
                if let matchingStyle = lineStyles[key] {
                    _lineStylesArray.append(KeyAndLineStyle(key: key, style: matchingStyle))
                }
            }
            
            return _lineStylesArray
        }
    }
    
    private var barStyles: [String : BarStyle]
    private var barStylesArray: [KeyAndBarStyle] {
        get {
            var _barStylesArray: [KeyAndBarStyle] = []
            
            let barStyleKeys = graphStyles.keys.sorted()
            for key in barStyleKeys {
                if let matchingStyle = barStyles[key] {
                    _barStylesArray.append(KeyAndBarStyle(key: key, style: matchingStyle))
                }
            }
            
            return _barStylesArray
        }
    }
    
    private func getNextAvailableLineGraphKey() -> String {
        var index = 0
        var graphStr = "Graph"
        while lineGraphs["\(graphStr)\(index)"] != nil {
            index += 1
            if (index == 0) {
                graphStr = "\(graphStr)\(index)"
            }
        }
        return "\(graphStr)\(index)"
    }
    
    private func getNextAvailableBarGraphKey() -> String {
        var index = 0
        var graphStr = "Graph"
        while barGraphs["\(graphStr)\(index)"] != nil {
            index += 1
            if (index == 0) {
                graphStr = "\(graphStr)\(index)"
            }
        }
        return "\(graphStr)\(index)"
    }
    
    
    // MARK: - Persistent Storage Implementation
    
    private let lineGraphsURL: URL
    
    private func saveLineGraphs() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        
        do {
            try archiver.encodeEncodable(lineGraphsArray, forKey: NSKeyedArchiveRootObjectKey)
            try archiver.encodedData.write(to: lineGraphsURL)
        } catch {
            print(error)
        }
    }
    
    private let barGraphsURL: URL
    
    private func saveBarGraphs() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        
        do {
            try archiver.encodeEncodable(barGraphsArray, forKey: NSKeyedArchiveRootObjectKey)
            try archiver.encodedData.write(to: barGraphsURL)
        } catch {
            print(error)
        }
    }
    
    private let graphStylesURL: URL
    
    private func saveGraphStyles() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        
        do {
            try archiver.encodeEncodable(graphStylesArray, forKey: NSKeyedArchiveRootObjectKey)
            try archiver.encodedData.write(to: graphStylesURL)
        } catch {
            print(error)
        }
    }
    
    private let lineStylesURL: URL
    
    private func saveLineStyles() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        
        do {
            try archiver.encodeEncodable(lineStylesArray, forKey: NSKeyedArchiveRootObjectKey)
            try archiver.encodedData.write(to: lineStylesURL)
        } catch {
            print(error)
        }
    }
    
    private let barStylesURL: URL
    
    private func saveBarStyles() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        
        do {
            try archiver.encodeEncodable(barStylesArray, forKey: NSKeyedArchiveRootObjectKey)
            try archiver.encodedData.write(to: barStylesURL)
        } catch {
            print(error)
        }
    }
    
}
