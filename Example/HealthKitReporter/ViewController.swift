//
//  ViewController.swift
//  HealthKitReporter
//
//  Created by Victor Kachalov on 09/14/2020.
//  Copyright (c) 2020 Victor Kachalov. All rights reserved.
//

import UIKit
import HealthKitReporter

class ViewController: UIViewController {
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var readRecordButton: UIButton!

    private let healthKitReporterSerivce = HealthKitReporterService()
    private var isRecordAvalible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        readButton.isEnabled = false
        writeButton.isEnabled = false
        readRecordButton.isEnabled = false
        isRecordAvalible = healthKitReporterSerivce.isClinicalRecordsAvailable()
    }

    @IBAction func authorizeButtonTapped(_ sender: UIButton) {
        healthKitReporterSerivce.requestAuthorization { success, error in
            if success && error == nil {
                DispatchQueue.main.async { [unowned self] in
                    let alert = UIAlertController(
                        title: "HK",
                        message: "HK Authorized",
                        preferredStyle: .alert
                    )
                    alert.addAction(
                        UIAlertAction(
                            title: "OK",
                            style: .default
                        ) { [unowned self] (_) in
                            self.readButton.isEnabled = true
                            self.writeButton.isEnabled = true
                        }
                    )
                    self.present(alert, animated: true)
                }
            } else {
                print(error ?? "error")
            }
        }
    }
    @IBAction func readButtonTapped(_ sender: UIButton) {
        // 添加类型支持检查
        healthKitReporterSerivce.checkSupportedTypes()
        healthKitReporterSerivce.readCategories()
        healthKitReporterSerivce.readElectrocardiogram()
        healthKitReporterSerivce.readQuantitiesAndStatistics()
    }
    @IBAction func writeButtonTapped(_ sender: UIButton) {
        healthKitReporterSerivce.writeSteps()
        healthKitReporterSerivce.writeBloodPressureCorrelation()
        // 调用新增的方法
        healthKitReporterSerivce.writeNewQuantityTypes()
        healthKitReporterSerivce.writeNewCategoryTypes()
    }
    @IBAction func seriesButtonTapped(_ sender: UIButton) {
        healthKitReporterSerivce.readWorkoutRoutes()
        healthKitReporterSerivce.readHearbeatSeries()
    }
    @IBAction func authorizeRecordButtonTapped(_ sender: UIButton) {
        if (isRecordAvalible) {
            healthKitReporterSerivce.requestRecordAuthorization { success, error in
                if success && error == nil {
                    DispatchQueue.main.async { [unowned self] in
                        let alert = UIAlertController(
                            title: "Clinical",
                            message: "Clinical Authorized",
                            preferredStyle: .alert
                        )
                        alert.addAction(
                            UIAlertAction(
                                title: "OK",
                                style: .default
                            ) { [unowned self] (_) in
                                self.readRecordButton.isEnabled = true
                            }
                        )
                        self.present(alert, animated: true)
                    }
                } else {
                    print(error ?? "error")
                }
            }
        }
    }
    @IBAction func readRecordButtonTapped(_ sender: UIButton) {
        healthKitReporterSerivce.readClinicalRecords()
    }
}
