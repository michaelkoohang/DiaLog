//
//  BarGraphView.swift
//  DiaLog
//
//  Created by Michael on 7/24/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import ScrollableGraphView

class BarGraphView: CardView, ScrollableGraphViewDataSource {

    var data = [Double]()
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    
    init(title: String) {
        super.init()
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
        
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            logs.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            logs.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            logs.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            logs.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
        
    }
    
    // UI Components
    
    let title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.textColor = .secondaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
        
    let logs: ScrollableGraphView = {
        let g = ScrollableGraphView(frame: CGRect(x: 0, y: 0, width: 0, height: 250))
        g.backgroundFillColor = .clear
        g.shouldAnimateOnStartup = true
        g.shouldAnimateOnAdapt = true
        g.shouldAdaptRange = true
        g.shouldRangeAlwaysStartAtZero = true
        g.isScrollEnabled = false
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLineLabelFont = UIFont.systemFont(ofSize: 10, weight: .medium)
        referenceLines.dataPointLabelFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        referenceLines.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        referenceLines.referenceLineThickness = 0
        referenceLines.referenceLineColor = .secondarySystemGroupedBackground
        referenceLines.dataPointLabelColor = .tertiaryLabel
        referenceLines.referenceLineLabelColor = .tertiaryLabel
        
        let barPlot = BarPlot(identifier: "bar")
        barPlot.barColor = .systemRed
        barPlot.barWidth = 15
        barPlot.barLineWidth = 0
        barPlot.barLineColor = .systemRed
        barPlot.shouldRoundBarCorners = true
        barPlot.animationDuration = 1
        
        g.addReferenceLines(referenceLines: referenceLines)
        g.addPlot(plot: barPlot)
        g.isUserInteractionEnabled = false
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
