//
//  HealthKitReporterService.swift
//  HealthKitReporter_Example
//
//  Created by Victor Kachalov on 27.05.22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import HealthKitReporter

final class HealthKitReporterService {
    private var reporter: HealthKitReporter?

    private var typesToRead: [ObjectType] {
        var types: [ObjectType] = [
            QuantityType.stepCount,
            QuantityType.heartRate,
            QuantityType.bloodPressureSystolic,
            QuantityType.bloodPressureDiastolic,
            CategoryType.sleepAnalysis,
            QuantityType.heartRateVariabilitySDNN,
            SeriesType.heartbeatSeries,
            WorkoutType.workoutType,
            SeriesType.workoutRoute,
            // 新增的指标类型示例
            QuantityType.appleExerciseTime,
            QuantityType.appleStandTime,
            QuantityType.appleMoveTime,
            QuantityType.appleWalkingSteadiness,
            QuantityType.cyclingSpeed,
            QuantityType.cyclingPower,
            QuantityType.cyclingCadence,
            QuantityType.runningSpeed,
            QuantityType.runningPower,
            QuantityType.walkingSpeed,
            QuantityType.stairAscentSpeed,
            QuantityType.stairDescentSpeed,
            QuantityType.vo2Max,
            QuantityType.restingHeartRate,
            QuantityType.walkingHeartRateAverage,
            QuantityType.heartRateRecoveryOneMinute,
            QuantityType.bodyMass,
            QuantityType.bodyMassIndex,
            QuantityType.height,
            QuantityType.waistCircumference,
            QuantityType.bodyFatPercentage,
            QuantityType.oxygenSaturation,
            QuantityType.bloodGlucose,
            QuantityType.bloodAlcoholContent,
            QuantityType.respiratoryRate,
            QuantityType.bodyTemperature,
            QuantityType.basalBodyTemperature,
            QuantityType.appleSleepingWristTemperature,
            QuantityType.waterTemperature,
            QuantityType.uvExposure,
            QuantityType.timeInDaylight,
            QuantityType.underwaterDepth,
            QuantityType.environmentalAudioExposure,
            QuantityType.headphoneAudioExposure,
            QuantityType.environmentalSoundReduction,
            QuantityType.physicalEffort,
            QuantityType.estimatedWorkoutEffortScore,
            QuantityType.workoutEffortScore,
            QuantityType.appleSleepingBreathingDisturbances,
            QuantityType.atrialFibrillationBurden,
            QuantityType.peripheralPerfusionIndex,
            QuantityType.electrodermalActivity,
            QuantityType.forcedVitalCapacity,
            QuantityType.forcedExpiratoryVolume1,
            QuantityType.peakExpiratoryFlowRate,
            QuantityType.insulinDelivery,
            QuantityType.inhalerUsage,
            QuantityType.numberOfTimesFallen,
            QuantityType.numberOfAlcoholicBeverages,
            QuantityType.flightsClimbed,
            QuantityType.pushCount,
            QuantityType.swimmingStrokeCount,
            QuantityType.activeEnergyBurned,
            QuantityType.basalEnergyBurned,
            QuantityType.dietaryEnergyConsumed,
            QuantityType.leanBodyMass,
            QuantityType.nikeFuel,
            // 新增的分类类型示例
            CategoryType.appleStandHour,
            CategoryType.appleWalkingSteadinessEvent,
            CategoryType.highHeartRateEvent,
            CategoryType.lowHeartRateEvent,
            CategoryType.irregularHeartRhythmEvent,
            CategoryType.lowCardioFitnessEvent,
            CategoryType.mindfulSession,
            CategoryType.handwashingEvent,
            CategoryType.toothbrushingEvent,
            CategoryType.audioExposureEvent,
            CategoryType.environmentalAudioExposureEvent,
            CategoryType.headphoneAudioExposureEvent,
            CategoryType.sleepApneaEvent,
            CategoryType.sleepChanges,
            CategoryType.menstrualFlow,
            CategoryType.intermenstrualBleeding,
            CategoryType.ovulationTestResult,
            CategoryType.cervicalMucusQuality,
            CategoryType.contraceptive,
            CategoryType.lactation,
            CategoryType.pregnancy,
            CategoryType.pregnancyTestResult,
            CategoryType.progesteroneTestResult,
            CategoryType.irregularMenstrualCycles,
            CategoryType.infrequentMenstrualCycles,
            CategoryType.persistentIntermenstrualBleeding,
            CategoryType.prolongedMenstrualPeriods,
            CategoryType.bleedingDuringPregnancy,
            CategoryType.bleedingAfterPregnancy,
            CategoryType.abdominalCramps,
            CategoryType.acne,
            CategoryType.appetiteChanges,
            CategoryType.bloating,
            CategoryType.breastPain,
            CategoryType.chestTightnessOrPain,
            CategoryType.chills,
            CategoryType.constipation,
            CategoryType.coughing,
            CategoryType.diarrhea,
            CategoryType.dizziness,
            CategoryType.drySkin,
            CategoryType.fainting,
            CategoryType.fatigue,
            CategoryType.fever,
            CategoryType.generalizedBodyAche,
            CategoryType.hairLoss,
            CategoryType.headache,
            CategoryType.heartburn,
            CategoryType.hotFlashes,
            CategoryType.lowerBackPain,
            CategoryType.memoryLapse,
            CategoryType.moodChanges,
            CategoryType.nausea,
            CategoryType.nightSweats,
            CategoryType.pelvicPain,
            CategoryType.rapidPoundingOrFlutteringHeartbeat,
            CategoryType.runnyNose,
            CategoryType.sexualActivity,
            CategoryType.shortnessOfBreath,
            CategoryType.sinusCongestion,
            CategoryType.skippedHeartbeat,
            CategoryType.soreThroat,
            CategoryType.vaginalDryness,
            CategoryType.vomiting,
            CategoryType.wheezing,
            CategoryType.lossOfSmell,
            CategoryType.lossOfTaste,
        ]
        if #available(iOS 14.0, *) {
            types.append(ElectrocardiogramType.electrocardiogramType)
        }
        return types
    }
    private let typesToWrite: [QuantityType] = [
        .stepCount,
        .bloodPressureSystolic,
        .bloodPressureDiastolic,
        // 新增的可写指标类型示例
        .heartRate,
        .bodyMass,
        .bodyMassIndex,
        .height,
        .waistCircumference,
        .bodyFatPercentage,
        .oxygenSaturation,
        .bloodGlucose,
        .bloodAlcoholContent,
        .respiratoryRate,
        .bodyTemperature,
        .basalBodyTemperature,
        .uvExposure,
        .activeEnergyBurned,
        .basalEnergyBurned,
        .dietaryEnergyConsumed,
        .leanBodyMass,
        .flightsClimbed,
        .pushCount,
        .swimmingStrokeCount,
        .inhalerUsage,
        .numberOfTimesFallen,
        .numberOfAlcoholicBeverages,
    ]

    private var predicate: NSPredicate {
        let now = Date()
        return Query.predicateForSamples(
            withStart: now.addingTimeInterval(-1 * 3600 * 3600 * 24),
            end: now,
            options: .strictEndDate
        )
    }

    init() {
        if HealthKitReporter.isHealthDataAvailable {
            reporter = HealthKitReporter()
        } else {
            print("HealthKitReporter is not available")
        }
    }

    func requestAuthorization(completion: @escaping StatusCompletionBlock) {
        reporter?.manager.requestAuthorization(
            toRead: typesToRead,
            toWrite: typesToWrite,
            completion: completion
        )
    }

    func readCategories() {
        let manager = reporter?.manager
        let reader = reporter?.reader
        if let categoryTypes = typesToRead.filter({ $0 is CategoryType}) as? [CategoryType] {
            for type in categoryTypes {
                do {
                    if let query = try reader?.categoryQuery(
                        type: type,
                        predicate: predicate,
                        resultsHandler: { results, error in
                        if error == nil {
                            for element in results {
                                do {
                                    print(try element.encoded())
                                } catch {
                                    print(error)
                                }
                            }
                        } else {
                            print(error ?? "error")
                        }
                    }) {
                        manager?.executeQuery(query)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }

    func readElectrocardiogram() {
        let manager = reporter?.manager
        let reader = reporter?.reader
        do {
            if #available(iOS 14.0, *) {
                if let seriesQuery = try reader?.electrocardiogramQuery(
                    predicate: predicate,
                    resultsHandler: { samples, error in
                        if error == nil {
                            do {
                                print("Electrocardiograms:", try samples.encoded())
                            } catch {
                                print(error)
                            }
                        } else {
                            print(error ?? "readElectrocardiogram error")
                        }
                    }) {
                    manager?.executeQuery(seriesQuery)
                }
            } else {
                print("ecg is not available")
            }
        } catch {
            print(error)
        }
    }

    func readHearbeatSeries() {
        let manager = reporter?.manager
        let reader = reporter?.reader
        do {
            if let seriesQuery = try reader?.heartbeatSeriesQuery(
                predicate: predicate,
                resultsHandler: { samples, error in
                if error == nil {
                    do {
                        print("HearbeatSeries", try samples.encoded())
                    } catch {
                        print(error)
                    }
                } else {
                    print(error ?? "readHearbeatSeries error")
                }
            }) {
                manager?.executeQuery(seriesQuery)
            }
        } catch {
            print(error)
        }
    }

    func readWorkoutRoutes() {
        let manager = reporter?.manager
        let reader = reporter?.reader
        do {
            if let seriesQuery = try reader?.workoutRouteQuery(
                predicate: predicate,
                resultsHandler: { samples, error in
                if error == nil {
                    do {
                        print("WorkoutRoutes:", try samples.encoded())
                    } catch {
                        print(error)
                    }
                } else {
                    print(error ?? "readWorkoutRoutes error")
                }
            }) {
                manager?.executeQuery(seriesQuery)
            }
        } catch {
            print(error)
        }
    }

    func readQuantitiesAndStatistics() {
        let manager = reporter?.manager
        let reader = reporter?.reader
        if let quantityTypes = typesToRead.filter({ $0 is QuantityType}) as? [QuantityType] {
            manager?.preferredUnits(for: quantityTypes) { (preferredUnits, error) in
                if error == nil {
                    for preferredUnit in preferredUnits {
                        do {
                            if let quantityQuery = try reader?.quantityQuery(
                                type: try QuantityType.make(from: preferredUnit.identifier),
                                unit: preferredUnit.unit,
                                resultsHandler: { (results, error) in
                                    if error == nil {
                                        for element in results {
                                            do {
                                                print("Quantity", try element.encoded())
                                            } catch {
                                                print(error)
                                            }
                                        }
                                    } else {
                                        print(error ?? "readQuantitiesAndStatistics error")
                                    }
                                }
                            ) {
                                manager?.executeQuery(quantityQuery)
                            }
                            if let statisticsQuery = try reader?.statisticsQuery(
                                type: try QuantityType.make(from: preferredUnit.identifier),
                                unit: preferredUnit.unit,
                                completionHandler: { (element, error) in
                                    if error == nil {
                                        do {
                                            print("Statistics", try element.encoded())
                                        } catch {
                                            print(error)
                                        }
                                    } else {
                                        print(error ?? "readQuantitiesAndStatistics error")
                                    }
                                }
                            ) {
                                manager?.executeQuery(statisticsQuery)
                            }
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error ?? "readQuantitiesAndStatistics error")
                }
            }
        }
    }

    func writeBloodPressureCorrelation() {
        let now = Date()
        let minuteAgo = now.addingTimeInterval(-60)
        let device = Device(
            name: "Guy's iPhone",
            manufacturer: "Guy",
            model: "6.1.1",
            hardwareVersion: "some_0",
            firmwareVersion: "some_1",
            softwareVersion: "some_2",
            localIdentifier: "some_3",
            udiDeviceIdentifier: "some_4"
        )
        let source = Source(
            name: "mySource",
            bundleIdentifier: "com.kvs.hkreporter"
        )
        let operatingSystem = SourceRevision.OperatingSystem(
            majorVersion: 1,
            minorVersion: 1,
            patchVersion: 1
        )
        let sourceRevision = SourceRevision(
            source: source,
            version: "1.0.0",
            productType: "CocoaPod",
            systemVersion: "1.0.0.0",
            operatingSystem: operatingSystem
        )
        let sys = Quantity(
            identifier: QuantityType.bloodPressureSystolic.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 123.0,
                unit: "mmHg",
                metadata: ["you": "saved it"]
            )
        )
        let dias = Quantity(
            identifier: QuantityType.bloodPressureDiastolic.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 83.0,
                unit: "mmHg",
                metadata: ["you": "saved it"]
            )
        )
        let correlation = Correlation(
            identifier: CorrelationType.bloodPressure.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device, sourceRevision: sourceRevision,
            harmonized: Correlation.Harmonized(
                quantitySamples: [sys, dias],
                categorySamples: [],
                metadata: ["you": "saved it"]
            )
        )
        do {
            print("BloodPressureCorrelation:", try correlation.encoded())
            let writer = reporter?.writer
            writer?.save(sample: correlation) { success, error in
                print("BloodPressureCorrelation saved:", success)
                print("BloodPressureCorrelation erorr:", error ?? "no erorr")
            }
        } catch {
            print(error)
        }
    }

    func writeSteps() {
        let manager = reporter?.manager
        let writer = reporter?.writer
        manager?.preferredUnits(for: typesToWrite) { (preferredUnits, _) in
            for preferredUnit in preferredUnits {
                let identifier = preferredUnit.identifier
                guard
                    identifier == QuantityType.stepCount.identifier
                else {
                    return
                }
                let now = Date()
                let quantity = Quantity(
                    identifier: identifier,
                    startTimestamp: now.addingTimeInterval(-60).timeIntervalSince1970,
                    endTimestamp: now.timeIntervalSince1970,
                    device: Device(
                        name: "Guy's iPhone",
                        manufacturer: "Guy",
                        model: "6.1.1",
                        hardwareVersion: "some_0",
                        firmwareVersion: "some_1",
                        softwareVersion: "some_2",
                        localIdentifier: "some_3",
                        udiDeviceIdentifier: "some_4"
                    ),
                    sourceRevision: SourceRevision(
                        source: Source(
                            name: "mySource",
                            bundleIdentifier: "com.kvs.hkreporter"
                        ),
                        version: "1.0.0",
                        productType: "CocoaPod",
                        systemVersion: "1.0.0.0",
                        operatingSystem: SourceRevision.OperatingSystem(
                            majorVersion: 1,
                            minorVersion: 1,
                            patchVersion: 1
                        )
                    ),
                    harmonized: Quantity.Harmonized(
                        value: 123.0,
                        unit: preferredUnit.unit,
                        metadata: nil
                    )
                )
                do {
                    print("StepsQuantity:", try quantity.encoded())
                    writer?.save(sample: quantity) { success, error in
                        print("StepsQuantity saved:", success)
                        print("StepsQuantity erorr:", error ?? "error")
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    // 新增方法：演示写入新增的指标类型
    func writeNewQuantityTypes() {
        let writer = reporter?.writer
        let now = Date()
        let minuteAgo = now.addingTimeInterval(-60)
        
        let device = Device(
            name: "Guy's iPhone",
            manufacturer: "Guy",
            model: "6.1.1",
            hardwareVersion: "some_0",
            firmwareVersion: "some_1",
            softwareVersion: "some_2",
            localIdentifier: "some_3",
            udiDeviceIdentifier: "some_4"
        )
        
        let sourceRevision = SourceRevision(
            source: Source(
                name: "mySource",
                bundleIdentifier: "com.kvs.hkreporter"
            ),
            version: "1.0.0",
            productType: "CocoaPod",
            systemVersion: "1.0.0.0",
            operatingSystem: SourceRevision.OperatingSystem(
                majorVersion: 1,
                minorVersion: 1,
                patchVersion: 1
            )
        )
        
        // 写入心率数据
        let heartRate = Quantity(
            identifier: QuantityType.heartRate.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 75.0,
                unit: "count/min",
                metadata: ["source": "demo"]
            )
        )
        
        // 写入体重数据
        let bodyMass = Quantity(
            identifier: QuantityType.bodyMass.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 70.5,
                unit: "kg",
                metadata: ["source": "demo"]
            )
        )
        
        // 写入身高数据
        let height = Quantity(
            identifier: QuantityType.height.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 175.0,
                unit: "cm",
                metadata: ["source": "demo"]
            )
        )
        
        // 写入血氧饱和度数据
        let oxygenSaturation = Quantity(
            identifier: QuantityType.oxygenSaturation.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 98.0,
                unit: "%",
                metadata: ["source": "demo"]
            )
        )
        
        // 写入血糖数据
        let bloodGlucose = Quantity(
            identifier: QuantityType.bloodGlucose.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 5.5,
                unit: "mg/dL",
                metadata: ["source": "demo"]
            )
        )
        
        // 写入体温数据
        let bodyTemperature = Quantity(
            identifier: QuantityType.bodyTemperature.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 36.8,
                unit: "°C",
                metadata: ["source": "demo"]
            )
        )
        
        // 写入活动能量消耗数据
        let activeEnergyBurned = Quantity(
            identifier: QuantityType.activeEnergyBurned.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 250.0,
                unit: "kcal",
                metadata: ["source": "demo"]
            )
        )
        
        // 保存所有新增的指标数据
        let samples: [Quantity] = [
            heartRate,
            bodyMass,
            height,
            oxygenSaturation,
            bloodGlucose,
            bodyTemperature,
            activeEnergyBurned
        ]
        
        for sample in samples {
            do {
                print("NewQuantityType:", try sample.encoded())
                writer?.save(sample: sample) { success, error in
                    print("NewQuantityType saved:", success)
                    print("NewQuantityType error:", error ?? "no error")
                }
            } catch {
                print("Error encoding sample:", error)
            }
        }
    }
    
    // 新增方法：演示写入新增的分类类型
    func writeNewCategoryTypes() {
        let writer = reporter?.writer
        let now = Date()
        let minuteAgo = now.addingTimeInterval(-60)
        
        let device = Device(
            name: "Guy's iPhone",
            manufacturer: "Guy",
            model: "6.1.1",
            hardwareVersion: "some_0",
            firmwareVersion: "some_1",
            softwareVersion: "some_2",
            localIdentifier: "some_3",
            udiDeviceIdentifier: "some_4"
        )
        
        let sourceRevision = SourceRevision(
            source: Source(
                name: "mySource",
                bundleIdentifier: "com.kvs.hkreporter"
            ),
            version: "1.0.0",
            productType: "CocoaPod",
            systemVersion: "1.0.0.0",
            operatingSystem: SourceRevision.OperatingSystem(
                majorVersion: 1,
                minorVersion: 1,
                patchVersion: 1
            )
        )
        
        // 写入睡眠分析数据
        let sleepAnalysis = Category(
            identifier: CategoryType.sleepAnalysis.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Category.Harmonized(
                value: 1, // 深度睡眠
                description: "Deep Sleep",
                detail: "User was in deep sleep",
                metadata: ["source": "demo"]
            )
        )
        
        // 写入正念会话数据
        let mindfulSession = Category(
            identifier: CategoryType.mindfulSession.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Category.Harmonized(
                value: 1, // 正念会话
                description: "Mindful Session",
                detail: "User completed a mindful session",
                metadata: ["source": "demo"]
            )
        )
        
        // 写入洗手事件数据
        let handwashingEvent = Category(
            identifier: CategoryType.handwashingEvent.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Category.Harmonized(
                value: 1, // 洗手事件
                description: "Handwashing Event",
                detail: "User washed hands",
                metadata: ["source": "demo"]
            )
        )
        
        // 保存所有新增的分类数据
        let samples: [Category] = [
            sleepAnalysis,
            mindfulSession,
            handwashingEvent
        ]
        
        for sample in samples {
            do {
                print("NewCategoryType:", try sample.encoded())
                writer?.save(sample: sample) { success, error in
                    print("NewCategoryType saved:", success)
                    print("NewCategoryType error:", error ?? "no error")
                }
            } catch {
                print("Error encoding sample:", error)
            }
        }
    }
}
