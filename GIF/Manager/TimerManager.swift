//
//  TimerManager.swift
//  GIF
//
//  Created by admin on 03.06.2021.
//

import Foundation

// MARK: TimerManagerDelegate
protocol TimerManagerDelegate: class {
    func timerСompleted()
}

class TimerManager: TimerManagerProtocol {
    
    // MARK: Properties
    private var timer: Timer?
    weak var delegate: TimerManagerDelegate?
    let timeDelay: Double
    
    init(timeDelay: Double) {
        self.timeDelay = timeDelay
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: timeDelay, target: self, selector: #selector(gettingImageLinks), userInfo: nil, repeats: false)
    }
    
    @objc func gettingImageLinks(){
        delegate?.timerСompleted()
    }
}

