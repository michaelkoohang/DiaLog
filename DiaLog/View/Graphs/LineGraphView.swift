//
//  LineGraphView.swift
//  DiaLog
//
//  Created by Michael on 7/24/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import ScrollableGraphView

class LineGraphView: CardView, ScrollableGraphViewDataSource {
    
    var data = [Double]()
    let days = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    
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
            logs.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            logs.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
        
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
        g.backgroundFillColor = .secondarySystemGroupedBackground
        g.shouldAnimateOnStartup = true
        g.shouldAnimateOnAdapt = true
        g.shouldRangeAlwaysStartAtZero = true
        g.rangeMax = 15
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.dataPointLabelFont = UIFont.boldSystemFont(ofSize: 12)
        referenceLines.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        referenceLines.referenceLineThickness = 0
        referenceLines.referenceLineColor = .tertiarySystemBackground
        referenceLines.dataPointLabelColor = .label
        referenceLines.referenceLineLabelColor = .label
        
        let linePlot = LinePlot(identifier: "line") // Identifier should be unique for each plot.
        linePlot.lineColor = UIColor(red: 61/255, green: 237/255, blue: 87/255, alpha: 1)
        linePlot.lineWidth = 0.5
        linePlot.lineStyle = .smooth
        linePlot.animationDuration = 1
        linePlot.fillGradientEndColor = .systemGreen
        linePlot.fillGradientStartColor = .systemGreen
        linePlot.fillColor = .systemGreen
        
        let dotPlot = DotPlot(identifier: "dot")
        dotPlot.dataPointFillColor = UIColor(red: 61/255, green: 237/255, blue: 87/255, alpha: 1)
        dotPlot.dataPointType = .circle
        dotPlot.dataPointSize = 3
        
        g.addPlot(plot: linePlot)
        g.addPlot(plot: dotPlot)
        g.addReferenceLines(referenceLines: referenceLines)
        g.translatesAutoresizingMaskIntoConstraints = false
        return g
    }()
    
    // Logic
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        // Return the data for each plot.
        switch(plot.identifier) {
        case "line":
            return data[pointIndex]
        case "dot":
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

