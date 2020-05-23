//
//  BarGraphView.swift
//  DiaLog
//
//  Created by Michael on 7/24/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import ScrollableGraphView

class BarGraphView: UIView, ScrollableGraphViewDataSource {

    var data = [Double]()
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    
    init(title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 15
        self.translatesAutoresizingMaskIntoConstraints = false
        self.title.text = title
        logs.dataSource = self
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.addSubview(title)
        self.addSubview(logs)
        
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        
        logs.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        logs.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        logs.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        logs.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
    }
    
    // UI Components
    
    let title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        l.textColor = .label
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
        
    let logs: ScrollableGraphView = {
        let g = ScrollableGraphView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        g.backgroundFillColor = .secondarySystemBackground
        g.shouldAnimateOnStartup = true
        g.shouldAnimateOnAdapt = true
        g.shouldAdaptRange = true
        g.rangeMax = 500
        g.shouldRangeAlwaysStartAtZero = true
        g.isScrollEnabled = false
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLineLabelFont = UIFont.systemFont(ofSize: 8, weight: .light)
        referenceLines.dataPointLabelFont = UIFont.systemFont(ofSize: 14, weight: .light)
        referenceLines.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        referenceLines.referenceLineThickness = 0.1
        referenceLines.referenceLineColor = .secondarySystemBackground
        referenceLines.dataPointLabelColor = .label
        referenceLines.referenceLineLabelColor = .label
        
        let barPlot = BarPlot(identifier: "bar")
        barPlot.barColor = .systemRed
        barPlot.barWidth = 15
        barPlot.barLineWidth = 0
        barPlot.barLineColor = .systemRed
        barPlot.shouldRoundBarCorners = true
        barPlot.animationDuration = 1
        
        g.addPlot(plot: barPlot)
        g.addReferenceLines(referenceLines: referenceLines)
        g.translatesAutoresizingMaskIntoConstraints = false
        return g
    }()
    
    // Logic
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        // Return the data for each plot.
        switch(plot.identifier) {
        case "bar":
            return data[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return days[pointIndex]
    }
    
    func numberOfPoints() -> Int {
        return data.count
    }

    func updateGraph(data: [Double]) {
        self.data = data
        self.logs.reload()
    }

}
