//
//  LineGraphView.swift
//  DiaLog
//
//  Created by Michael on 7/24/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import ScrollableGraphView

class LineGraphView: UIView, ScrollableGraphViewDataSource {
    
    var data = [Double]()
    let days = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    
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
        self.addSubview(button)
        self.addSubview(logs)
        
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        logs.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        logs.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        logs.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
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

    let button: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 5
        b.setTitle("See All", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let logs: ScrollableGraphView = {
        let g = ScrollableGraphView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        g.backgroundFillColor = .secondarySystemBackground
        g.shouldAnimateOnStartup = true
        g.shouldAnimateOnAdapt = true
        g.shouldRangeAlwaysStartAtZero = true
        g.rangeMax = 15
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.dataPointLabelFont = UIFont.boldSystemFont(ofSize: 12)
        referenceLines.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        referenceLines.referenceLineThickness = 0.1
        referenceLines.referenceLineColor = .secondarySystemBackground
        referenceLines.dataPointLabelColor = .label
        referenceLines.referenceLineLabelColor = .label
        
        let linePlot = LinePlot(identifier: "line") // Identifier should be unique for each plot.
        linePlot.lineColor = UIColor(red: 61/255, green: 237/255, blue: 87/255, alpha: 1)
        linePlot.lineWidth = 0.5
        linePlot.lineStyle = .smooth
        linePlot.animationDuration = 1
        linePlot.fillColor = UIColor(red: 61/255, green: 237/255, blue: 87/255, alpha: 1)
        
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

