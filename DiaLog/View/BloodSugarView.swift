//
//  BloodSugarView.swift
//  DiaLog
//
//  Created by Michael on 7/8/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData
import Charts
import ScrollableGraphView

class BloodSugarView: CardView, ScrollableGraphViewDataSource {
    
    var todayData = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    let times = ["BB", "AB", "BL", "AL", "BD", "AD"]
    
    override init() {
        super.init()
        logs.dataSource = self
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    func setup() {
        self.addSubview(title)
        self.addSubview(targetGoalTitle)
        self.addSubview(editButton)
        self.addSubview(targetGoalLabel)
        self.addSubview(units)
        self.addSubview(logsLabel)
        self.addSubview(logs)
        
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        
        targetGoalTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        targetGoalTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        editButton.centerYAnchor.constraint(equalTo: targetGoalTitle.centerYAnchor, constant: 2).isActive = true
        editButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        targetGoalLabel.topAnchor.constraint(equalTo: targetGoalTitle.bottomAnchor, constant: 8).isActive = true
        targetGoalLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        units.lastBaselineAnchor.constraint(equalTo: targetGoalLabel.lastBaselineAnchor, constant: 0).isActive = true
        units.leftAnchor.constraint(equalTo: targetGoalLabel.rightAnchor, constant: 12).isActive = true
        
        logsLabel.topAnchor.constraint(equalTo: targetGoalLabel.bottomAnchor, constant: 16).isActive = true
        logsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true

        logs.topAnchor.constraint(equalTo: logsLabel.bottomAnchor, constant: 16).isActive = true
        logs.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        logs.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        logs.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    // UI Components
    
    let title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        l.textColor = .systemRed
        l.text = "Blood Sugar"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let targetGoalTitle: UILabel = {
        let l = UILabel()
        l.text = "Target Goal"
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    let editButton: UIButton = {
        let b = UIButton()
        b.setTitle("Edit", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 5
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let targetGoalPicker: UIPickerView = {
        var p = UIPickerView()
        return p
    }()
    
    let targetGoalLabel: UILabel = {
        let l = UILabel()
        l.text = "0"
        l.textColor = .systemRed
        l.font = UIFont.systemFont(ofSize: 64, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let units: UILabel = {
        let l = UILabel()
        l.text = "mg / dL"
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 32, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let logsLabel: UILabel = {
        let l = UILabel()
        l.text = "Today's Logs"
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let logs: ScrollableGraphView = {
        let g = ScrollableGraphView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        g.backgroundFillColor = .secondarySystemBackground
        g.dataPointSpacing = 45
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
        
        g.addReferenceLines(referenceLines: referenceLines)
        g.addPlot(plot: barPlot)
        g.translatesAutoresizingMaskIntoConstraints = false
        return g
    }()
    
    
    // Logic
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        // Return the data for each plot.
        switch(plot.identifier) {
        case "bar":
            return todayData[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return times[pointIndex]
    }
    
    func numberOfPoints() -> Int {
        return todayData.count
    }
    
    func setTargetBloodSugar(data: String) {
        self.targetGoalLabel.text = data
    }
    
    func updateTodayGraph(data: [Double]) {
        self.todayData = data
        self.logs.reload()
    }
    
}
