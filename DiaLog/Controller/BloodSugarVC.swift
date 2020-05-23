//
//  BloodSugarVC.swift
//  DiaLog
//
//  Created by Michael on 2/4/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData

class BloodSugarVC: UIViewController {
            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToLog))
        seeAllButton.addTarget(self, action: #selector(showAllLogs), for: .touchUpInside)
        self.title = "Blood Sugar"
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadGraphs()
    }
    
    func setup() {
        self.dataView.addSubview(dailyAverage)
        self.dataView.addSubview(seeAllButton)
        self.dataView.addSubview(beforeBreakfast)
        self.dataView.addSubview(afterBreakfast)
        self.dataView.addSubview(beforeLunch)
        self.dataView.addSubview(afterLunch)
        self.dataView.addSubview(beforeDinner)
        self.dataView.addSubview(afterDinner)
        self.view.addSubview(dataView)
        
        dataView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        dataView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        dataView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        dataView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
                    
        dailyAverage.topAnchor.constraint(equalTo: self.dataView.topAnchor, constant: 14).isActive = true
        dailyAverage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        dailyAverage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        dailyAverage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        seeAllButton.topAnchor.constraint(equalTo: self.dailyAverage.topAnchor, constant: 16).isActive = true
        seeAllButton.rightAnchor.constraint(equalTo: self.dailyAverage.rightAnchor, constant: -16).isActive = true
        seeAllButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        seeAllButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        beforeBreakfast.topAnchor.constraint(equalTo: self.dailyAverage.bottomAnchor, constant: 14).isActive = true
        beforeBreakfast.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        beforeBreakfast.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        beforeBreakfast.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        afterBreakfast.topAnchor.constraint(equalTo: self.beforeBreakfast.bottomAnchor, constant: 14).isActive = true
        afterBreakfast.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        afterBreakfast.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        afterBreakfast.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        beforeLunch.topAnchor.constraint(equalTo: self.afterBreakfast.bottomAnchor, constant: 14).isActive = true
        beforeLunch.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        beforeLunch.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        beforeLunch.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        afterLunch.topAnchor.constraint(equalTo: self.beforeLunch.bottomAnchor, constant: 14).isActive = true
        afterLunch.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        afterLunch.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        afterLunch.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        beforeDinner.topAnchor.constraint(equalTo: self.afterLunch.bottomAnchor, constant: 14).isActive = true
        beforeDinner.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        beforeDinner.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        beforeDinner.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        afterDinner.topAnchor.constraint(equalTo: self.beforeDinner.bottomAnchor, constant: 14).isActive = true
        afterDinner.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        afterDinner.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        afterDinner.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    // UI Components
    
    let dataView: UIScrollView = {
        var v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 2225)
        return v
    }()
    
    let dailyAverage = BarGraphView(title: "Daily Average")
    
    let seeAllButton: UIButton = {
        let b = UIButton()
        b.setTitle("See All", for: .normal)
        b.layer.cornerRadius = 5
        b.setTitleColor(UIColor.white, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        b.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let beforeBreakfast = BarGraphView(title: "Before Breakfast")
    let afterBreakfast = BarGraphView(title: "After Breakfast")
    let beforeLunch = BarGraphView(title: "Before Lunch")
    let afterLunch = BarGraphView(title: "After Lunch")
    let beforeDinner = BarGraphView(title: "Before Dinner")
    let afterDinner = BarGraphView(title: "After Dinner")
    
    // Navigation
    
    @objc func goToLog() {
        let addBloodSugarVC = AddBloodSugarVC()
        addBloodSugarVC.callbackClosure = { [weak self] in
            self!.reloadGraphs()
        }
        self.navigationController?.present(addBloodSugarVC, animated: true, completion: nil)
    }
    
    @objc func showAllLogs() {
        self.navigationController?.pushViewController(AllBloodSugarVC(), animated: true)
    }
        
    // Logic
    
    func reloadGraphs() {
        let dailyAverageData = getBloodSugar(predicate: NSPredicate(format: "type != %@", "Target"))
        dailyAverage.updateGraph(data: extractLogs(data: dailyAverageData))
        
        let beforeBreakfastData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "Before Breakfast"))
        beforeBreakfast.updateGraph(data: extractLogs(data: beforeBreakfastData))
        
        let afterBreakfastData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "After Breakfast"))
        afterBreakfast.updateGraph(data: extractLogs(data: afterBreakfastData))
        
        let beforeLunchData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "Before Lunch"))
        beforeLunch.updateGraph(data: extractLogs(data: beforeLunchData))
        
        let afterLunchData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "After Lunch"))
        afterLunch.updateGraph(data: extractLogs(data: afterLunchData))
        
        let beforeDinnerData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "Before Dinner"))
        beforeDinner.updateGraph(data: extractLogs(data: beforeDinnerData))
        
        let afterDinnerData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "After Dinner"))
        afterDinner.updateGraph(data: extractLogs(data: afterDinnerData))
    }
    
    func getBloodSugar(predicate: NSPredicate) -> [BloodSugar] {
        var result = [BloodSugar]()
        let fetchRequest: NSFetchRequest<BloodSugar> = BloodSugar.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            result = try PersistanceService.context.fetch(fetchRequest)
            return result
        } catch {
            print("error")
        }
        return result
    }
    
    func extractLogs(data: [BloodSugar]) -> [Double] {
        var result = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        var sun = 0.0, sunCount = 0.0
        var mon = 0.0, monCount = 0.0
        var tue = 0.0, tueCount = 0.0
        var wed = 0.0, wedCount = 0.0
        var thu = 0.0, thuCount = 0.0
        var fri = 0.0, friCount = 0.0
        var sat = 0.0, satCount = 0.0
        
        for bs in data {
            let calendar = Calendar.current
            let day = calendar.component(.weekday, from: bs.date!)
            switch day {
            case 1:
                sun += Double(bs.value)
                sunCount += 1
            case 2:
                mon += Double(bs.value)
                monCount += 1
            case 3:
                tue += Double(bs.value)
                tueCount += 1
            case 4:
                wed += Double(bs.value)
                wedCount += 1
            case 5:
                thu += Double(bs.value)
                thuCount += 1
            case 6:
                fri += Double(bs.value)
                friCount += 1
            case 7:
                sat += Double(bs.value)
                satCount += 1
            default:
                print("NONE FOUND")
            }
        }
        
        result[0] = (sunCount > 0) ? sun / sunCount : 0.0
        result[1] = (monCount > 0) ? mon / monCount : 0.0
        result[2] = (tueCount > 0) ? tue / tueCount : 0.0
        result[3] = (wedCount > 0) ? wed / wedCount : 0.0
        result[4] = (thuCount > 0) ? thu / thuCount : 0.0
        result[5] = (friCount > 0) ? fri / friCount : 0.0
        result[6] = (satCount > 0) ? sat / satCount : 0.0

        return result
    }
    
}

