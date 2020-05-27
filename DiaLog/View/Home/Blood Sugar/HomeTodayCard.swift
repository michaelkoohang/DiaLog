//
//  HomeTodayCard.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/24/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit
import Lottie
import CoreData
import ScrollableGraphView

class HomeTodayCard: HomeCard, ScrollableGraphViewDataSource {

    var todayData: [Double] = []
    let times = ["BB", "AB", "BL", "AL", "BD", "AD"]
    var logsHeight: NSLayoutConstraint?
    
    init() {
        super.init(style: .default, reuseIdentifier: "hbsc")
        NotificationCenter.default.addObserver(self, selector:#selector(restartAnimation), name:
        UIApplication.willEnterForegroundNotification, object: nil)
        logs.dataSource = self
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.contentView.addSubview(logsLabel)
        self.contentView.addSubview(chevron)
        self.contentView.addSubview(logs)
        self.contentView.addSubview(noDataLabel)
        self.contentView.addSubview(startLoggingLabel)
        self.contentView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            logsLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            logsLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            chevron.centerYAnchor.constraint(equalTo: logsLabel.centerYAnchor, constant: 0),
            chevron.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            chevron.heightAnchor.constraint(equalToConstant: 20),
            chevron.widthAnchor.constraint(equalToConstant: 20),
            logs.topAnchor.constraint(equalTo: logsLabel.bottomAnchor, constant: 16),
            logs.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            logs.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            logs.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            noDataLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor, constant: -8),
            noDataLabel.leftAnchor.constraint(equalTo: self.animationView.rightAnchor, constant: 8),
            noDataLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            startLoggingLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor, constant: 12),
            startLoggingLabel.leftAnchor.constraint(equalTo: self.animationView.rightAnchor, constant: 8),
            startLoggingLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            animationView.topAnchor.constraint(equalTo: logsLabel.bottomAnchor, constant: 12),
            animationView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            animationView.heightAnchor.constraint(equalToConstant: 60),
            animationView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        logsHeight = logs.heightAnchor.constraint(equalToConstant: 250)
        logsHeight?.isActive = true
    
    }
    
    // UI Components
    
    let logsLabel: UILabel = {
        let l = UILabel()
        l.text = "Today"
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let chevron: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .tertiaryLabel
        iv.image = UIImage(systemName: "chevron.right")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let logs: ScrollableGraphView = {
        let g = ScrollableGraphView(frame: CGRect(x: 0, y: 0, width: 0, height: 250))
        g.backgroundFillColor = .clear
        g.dataPointSpacing = 45
        g.shouldAnimateOnStartup = true
        g.shouldAnimateOnAdapt = true
        g.shouldAdaptRange = true
        g.rangeMax = 500
        g.shouldRangeAlwaysStartAtZero = true
        g.isScrollEnabled = false
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLineLabelFont = UIFont.systemFont(ofSize: 10, weight: .medium)
        referenceLines.dataPointLabelFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        referenceLines.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        referenceLines.referenceLineThickness = 0
        referenceLines.referenceLineColor = .tertiarySystemBackground
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
    
    let noDataLabel: UILabel = {
        let l = UILabel()
        l.text = "No Logs"
        l.font = .systemFont(ofSize: 18, weight: .bold)
        l.textAlignment = .left
        l.textColor = .tertiaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let startLoggingLabel: UILabel = {
        let l = UILabel()
        l.text = "Start logging to see your data."
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textAlignment = .left
        l.textColor = .tertiaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let animationView: AnimationView = {
        let a = AnimationView()
        a.animation = Animation.named("heart")
        a.contentMode = .scaleAspectFit
        a.loopMode = .loop
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
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
    
    func updateToday(data: [Double]) {
        var empty = true
        for val in data {
            if val != 0.0 {
                empty = false
            }
        }
        
        if empty {
            logs.isHidden = true
            noDataLabel.isHidden = false
            startLoggingLabel.isHidden = false
            animationView.isHidden = false
            animationView.play()
            logsHeight?.constant = 60
        } else {
            logs.isHidden = false
            noDataLabel.isHidden = true
            startLoggingLabel.isHidden = true
            animationView.isHidden = true
            animationView.pause()
            logsHeight?.constant = 250
            self.todayData = data
            self.logs.reload()
        }
    }
    
    func configureCell() {
        updateToday(data: DBHandler.getTodayBloodSugar())
    }
    
    @objc func restartAnimation() {
        animationView.play()
    }

}
