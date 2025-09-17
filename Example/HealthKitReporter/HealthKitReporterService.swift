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
            // 基础类型 - 所有iOS版本都支持
            QuantityType.stepCount,
            QuantityType.heartRate,
            QuantityType.bloodPressureSystolic,
            QuantityType.bloodPressureDiastolic,
            CategoryType.sleepAnalysis,
            QuantityType.heartRateVariabilitySDNN,
            SeriesType.heartbeatSeries,
            WorkoutType.workoutType,
            SeriesType.workoutRoute,
            
            // 基础数量类型 - 所有iOS版本都支持
            QuantityType.activeEnergyBurned,
            QuantityType.basalEnergyBurned,
            QuantityType.bloodAlcoholContent,
            QuantityType.bloodGlucose,
            QuantityType.bodyFatPercentage,
            QuantityType.bodyMass,
            QuantityType.bodyMassIndex,
            QuantityType.bodyTemperature,
            QuantityType.dietaryEnergyConsumed,
            QuantityType.distanceCycling,
            QuantityType.distanceWalkingRunning,
            QuantityType.electrodermalActivity,
            QuantityType.flightsClimbed,
            QuantityType.forcedExpiratoryVolume1,
            QuantityType.forcedVitalCapacity,
            QuantityType.height,
            QuantityType.inhalerUsage,
            QuantityType.leanBodyMass,
            QuantityType.nikeFuel,
            QuantityType.numberOfTimesFallen,
            QuantityType.oxygenSaturation,
            QuantityType.peakExpiratoryFlowRate,
            QuantityType.peripheralPerfusionIndex,
            QuantityType.respiratoryRate,
            
            // 基础分类类型 - 所有iOS版本都支持
            CategoryType.menstrualFlow,
            CategoryType.ovulationTestResult,
            CategoryType.cervicalMucusQuality,
            CategoryType.highHeartRateEvent,
            CategoryType.lowHeartRateEvent,
            CategoryType.irregularHeartRhythmEvent,
            CategoryType.lowCardioFitnessEvent,
            CategoryType.intermenstrualBleeding,
            CategoryType.lactation,
            CategoryType.lossOfSmell,
            CategoryType.lossOfTaste,
            CategoryType.irregularMenstrualCycles,
            CategoryType.infrequentMenstrualCycles,
            CategoryType.sleepChanges,
        ]
        
        // iOS 9.0+ 支持的类型
        if #available(iOS 9.0, *) {
            types.append(contentsOf: [
                QuantityType.basalBodyTemperature,
                QuantityType.uvExposure,
//                CategoryType.appleStandHour
            ])
        }
        
        // iOS 9.3+ 支持的类型
        if #available(iOS 9.3, *) {
            types.append(QuantityType.appleExerciseTime)
        }
        
        // iOS 10.0+ 支持的类型
        if #available(iOS 10.0, *) {
            types.append(contentsOf: [
                QuantityType.distanceSwimming,
                QuantityType.distanceWheelchair,
                QuantityType.swimmingStrokeCount,
                QuantityType.pushCount
            ])
            
            types.append(CategoryType.mindfulSession)
        }
        
        // iOS 11.0+ 支持的类型
        if #available(iOS 11.0, *) {
            types.append(contentsOf: [
                QuantityType.insulinDelivery,
                QuantityType.restingHeartRate,
                QuantityType.walkingHeartRateAverage,
                QuantityType.vo2Max,
                QuantityType.waistCircumference
            ])
        }
        
        // iOS 11.2+ 支持的类型
        if #available(iOS 11.2, *) {
            types.append(QuantityType.distanceDownhillSnowSports)
        }
        
        // iOS 13.0+ 支持的类型
        if #available(iOS 13.0, *) {
            types.append(contentsOf: [
                QuantityType.appleStandTime,
                QuantityType.environmentalAudioExposure,
                QuantityType.headphoneAudioExposure
            ])
            
            types.append(CategoryType.audioExposureEvent)
        }
        
        // iOS 13.6+ 支持的类型
        if #available(iOS 13.6, *) {
            types.append(contentsOf: [
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
                CategoryType.wheezing
            ])
        }
        
        // iOS 14.0+ 支持的类型
        if #available(iOS 14.0, *) {
            types.append(contentsOf: [
                QuantityType.sixMinuteWalkTestDistance,
                QuantityType.stairAscentSpeed,
                QuantityType.stairDescentSpeed,
                QuantityType.walkingAsymmetryPercentage,
                QuantityType.walkingDoubleSupportPercentage,
                QuantityType.walkingSpeed,
                QuantityType.walkingStepLength
            ])
            
            types.append(contentsOf: [
                CategoryType.drySkin,
                CategoryType.environmentalAudioExposureEvent,
                CategoryType.handwashingEvent,
                CategoryType.headphoneAudioExposureEvent,
                CategoryType.nightSweats,
                CategoryType.toothbrushingEvent
            ])
            
            // 单独添加 ElectrocardiogramType，因为它需要明确的类型转换
            types.append(ElectrocardiogramType.electrocardiogramType as ObjectType)
        }
        
        // iOS 14.3+ 支持的类型
        if #available(iOS 14.3, *) {
            types.append(contentsOf: [
                CategoryType.contraceptive,
                CategoryType.pregnancy
            ])
        }
        
        // iOS 14.5+ 支持的类型
        if #available(iOS 14.5, *) {
            types.append(QuantityType.appleMoveTime)
        }
        
        // iOS 15.0+ 支持的类型
        if #available(iOS 15.0, *) {
            types.append(contentsOf: [
                QuantityType.appleWalkingSteadiness,
                QuantityType.numberOfAlcoholicBeverages
            ])
            
            types.append(contentsOf: [
                CategoryType.appleWalkingSteadinessEvent,
                CategoryType.pregnancyTestResult,
                CategoryType.progesteroneTestResult
            ])
        }
        
        // iOS 16.0+ 支持的类型
        if #available(iOS 16.0, *) {
            types.append(contentsOf: [
                QuantityType.appleSleepingWristTemperature,
                QuantityType.atrialFibrillationBurden,
                QuantityType.environmentalSoundReduction,
                QuantityType.runningGroundContactTime,
                QuantityType.runningPower,
                QuantityType.runningSpeed,
                QuantityType.runningStrideLength,
                QuantityType.runningVerticalOscillation,
                QuantityType.underwaterDepth,
                QuantityType.waterTemperature
            ])
            
            types.append(contentsOf: [
                CategoryType.persistentIntermenstrualBleeding,
                CategoryType.prolongedMenstrualPeriods
            ])
        }
        
        // iOS 17.0+ 支持的类型
        if #available(iOS 17.0, *) {
            types.append(contentsOf: [
                QuantityType.cyclingCadence,
                QuantityType.cyclingFunctionalThresholdPower,
                QuantityType.cyclingPower,
                QuantityType.cyclingSpeed,
                QuantityType.physicalEffort,
                QuantityType.timeInDaylight
            ])
        }
        
        // iOS 18.0+ 支持的类型
        if #available(iOS 18.0, *) {
            types.append(contentsOf: [
                QuantityType.appleSleepingBreathingDisturbances,
                QuantityType.crossCountrySkiingSpeed,
                QuantityType.distanceCrossCountrySkiing,
                QuantityType.distancePaddleSports,
                QuantityType.distanceRowing,
                QuantityType.distanceSkatingSports,
                QuantityType.estimatedWorkoutEffortScore,
                QuantityType.paddleSportsSpeed,
                QuantityType.rowingSpeed,
                QuantityType.workoutEffortScore
            ])

            types.append(contentsOf: [
                CategoryType.bleedingAfterPregnancy,
                CategoryType.bleedingDuringPregnancy,
                CategoryType.sleepApneaEvent,
            ])
        }
        
        return types
    }
    
    private var typesToWrite: [QuantityType] {
        var types: [QuantityType] = [
            // 基础可写类型 - 所有iOS版本都支持
            .stepCount,
            .bloodPressureSystolic,
            .bloodPressureDiastolic,
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
        
        // 根据iOS版本动态添加可写类型
        if #available(iOS 10.0, *) {
            types.append(contentsOf: [
                .distanceSwimming, 
                .distanceWheelchair
            ])
        }
        
        if #available(iOS 11.0, *) {
            types.append(contentsOf: [
                .insulinDelivery, 
                .restingHeartRate, 
                .vo2Max
            ])
        }
        
        if #available(iOS 14.0, *) {
            types.append(contentsOf: [
                .sixMinuteWalkTestDistance,
                .stairAscentSpeed, 
                .stairDescentSpeed, 
                .walkingDoubleSupportPercentage, 
                .walkingSpeed, 
                .walkingStepLength
            ])
        }
        
        if #available(iOS 16.0, *) {
            types.append(contentsOf: [
                .environmentalSoundReduction, 
                .runningGroundContactTime, 
                .runningPower, 
                .runningSpeed, 
                .runningStrideLength, 
                .runningVerticalOscillation, 
                .underwaterDepth, 
                .waterTemperature
            ])
        }
        
        if #available(iOS 17.0, *) {
            types.append(contentsOf: [
                .cyclingCadence, 
                .cyclingFunctionalThresholdPower, 
                .cyclingPower, 
                .cyclingSpeed, 
                .physicalEffort, 
                .timeInDaylight
            ])
        }
        
        if #available(iOS 18.0, *) {
            types.append(contentsOf: [
                .appleSleepingBreathingDisturbances, 
                .crossCountrySkiingSpeed, 
                .distanceCrossCountrySkiing, 
                .distancePaddleSports, 
                .distanceRowing, 
                .distanceSkatingSports, 
                .estimatedWorkoutEffortScore, 
                .paddleSportsSpeed, 
                .rowingSpeed, 
                .workoutEffortScore
            ])
        }
        
        return types
    }

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
            print("isClinicalRecordsAvailable: \(reporter!.manager.isClinicalRecordsAvailable)")
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
        
        var samples: [Quantity] = []
        
        // 基础类型 - 所有iOS版本都支持
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
        samples.append(heartRate)
        
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
        samples.append(bodyMass)
        
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
        samples.append(height)
        
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
        samples.append(oxygenSaturation)
        
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
        samples.append(bloodGlucose)
        
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
        samples.append(bodyTemperature)
        
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
        samples.append(activeEnergyBurned)
        
        // iOS 9.0+ 支持的类型
        let uvExposure = Quantity(
            identifier: QuantityType.uvExposure.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Quantity.Harmonized(
                value: 0.5,
                unit: "count",
                metadata: ["source": "demo"]
            )
        )
        samples.append(uvExposure)
        
        // iOS 11.0+ 支持的类型
        if #available(iOS 11.0, *) {
            let restingHeartRate = Quantity(
                identifier: QuantityType.restingHeartRate.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Quantity.Harmonized(
                    value: 65.0,
                    unit: "count/min",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(restingHeartRate)
            
            let vo2Max = Quantity(
                identifier: QuantityType.vo2Max.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Quantity.Harmonized(
                    value: 45.0,
                    unit: "ml/kg/min",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(vo2Max)
        }
        
        // iOS 14.0+ 支持的类型
        if #available(iOS 14.0, *) {
            let walkingSpeed = Quantity(
                identifier: QuantityType.walkingSpeed.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Quantity.Harmonized(
                    value: 1.2,
                    unit: "m/s",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(walkingSpeed)
        }
        
        // iOS 16.0+ 支持的类型
        if #available(iOS 16.0, *) {
            let runningSpeed = Quantity(
                identifier: QuantityType.runningSpeed.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Quantity.Harmonized(
                    value: 3.5,
                    unit: "m/s",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(runningSpeed)
            
            let runningPower = Quantity(
                identifier: QuantityType.runningPower.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Quantity.Harmonized(
                    value: 250.0,
                    unit: "W",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(runningPower)
        }
        
        // iOS 17.0+ 支持的类型
        if #available(iOS 17.0, *) {
            let cyclingPower = Quantity(
                identifier: QuantityType.cyclingPower.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Quantity.Harmonized(
                    value: 180.0,
                    unit: "W",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(cyclingPower)
            
            let cyclingSpeed = Quantity(
                identifier: QuantityType.cyclingSpeed.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Quantity.Harmonized(
                    value: 8.5,
                    unit: "m/s",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(cyclingSpeed)
        }
        
        // 保存所有支持的指标数据
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
        
        var samples: [Category] = []
        
        // 基础分类类型 - 所有iOS版本都支持
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
        samples.append(sleepAnalysis)
        
        // iOS 9.0+ 支持的分类类型
        let appleStandHour = Category(
            identifier: CategoryType.appleStandHour.identifier!,
            startTimestamp: minuteAgo.timeIntervalSince1970,
            endTimestamp: now.timeIntervalSince1970,
            device: device,
            sourceRevision: sourceRevision,
            harmonized: Category.Harmonized(
                value: 1, // 站立小时
                description: "Apple Stand Hour",
                detail: "User stood for an hour",
                metadata: ["source": "demo"]
            )
        )
        samples.append(appleStandHour)
        
        // iOS 10.0+ 支持的分类类型
        if #available(iOS 10.0, *) {
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
            samples.append(mindfulSession)
        }
        
        // iOS 14.0+ 支持的分类类型
        if #available(iOS 14.0, *) {
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
            samples.append(handwashingEvent)
            
            let toothbrushingEvent = Category(
                identifier: CategoryType.toothbrushingEvent.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Category.Harmonized(
                    value: 1, // 刷牙事件
                    description: "Toothbrushing Event",
                    detail: "User brushed teeth",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(toothbrushingEvent)
        }
        
        // iOS 15.0+ 支持的分类类型
        if #available(iOS 15.0, *) {
            let appleWalkingSteadinessEvent = Category(
                identifier: CategoryType.appleWalkingSteadinessEvent.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Category.Harmonized(
                    value: 1, // 步行稳定性事件
                    description: "Apple Walking Steadiness Event",
                    detail: "User walking steadiness event",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(appleWalkingSteadinessEvent)
        }
        
        // iOS 13.6+ 支持的分类类型
        if #available(iOS 13.6, *) {
            let headache = Category(
                identifier: CategoryType.headache.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Category.Harmonized(
                    value: 1, // 头痛
                    description: "Headache",
                    detail: "User experienced headache",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(headache)
            
            let fatigue = Category(
                identifier: CategoryType.fatigue.identifier!,
                startTimestamp: minuteAgo.timeIntervalSince1970,
                endTimestamp: now.timeIntervalSince1970,
                device: device,
                sourceRevision: sourceRevision,
                harmonized: Category.Harmonized(
                    value: 1, // 疲劳
                    description: "Fatigue",
                    detail: "User experienced fatigue",
                    metadata: ["source": "demo"]
                )
            )
            samples.append(fatigue)
        }
        
        // 保存所有支持的分类数据
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
    
    // 辅助方法：检查当前iOS版本支持的指标类型
    func checkSupportedTypes() {
        print("=== 当前iOS版本支持的指标类型检查 ===")
        
        // 检查数量类型支持
        print("\n--- 数量类型支持情况 ---")
        let quantityTypes: [(String, QuantityType, String)] = [
            ("基础类型", .stepCount, "所有iOS版本"),
            ("iOS 9.0+", .basalBodyTemperature, "iOS 9.0+"),
            ("iOS 9.3+", .appleExerciseTime, "iOS 9.3+"),
            ("iOS 10.0+", .distanceSwimming, "iOS 10.0+"),
            ("iOS 11.0+", .restingHeartRate, "iOS 11.0+"),
            ("iOS 11.2+", .distanceDownhillSnowSports, "iOS 11.2+"),
            ("iOS 13.0+", .appleStandTime, "iOS 13.0+"),
            ("iOS 14.0+", .walkingSpeed, "iOS 14.0+"),
            ("iOS 14.5+", .appleMoveTime, "iOS 14.5+"),
            ("iOS 15.0+", .appleWalkingSteadiness, "iOS 15.0+"),
            ("iOS 16.0+", .runningSpeed, "iOS 16.0+"),
            ("iOS 17.0+", .cyclingPower, "iOS 17.0+"),
            ("iOS 18.0+", .workoutEffortScore, "iOS 18.0+")
        ]
        
        for (name, type, requirement) in quantityTypes {
            if let original = type.original {
                print("✅ \(name): \(original) - \(requirement) - 支持")
            } else {
                print("❌ \(name): \(type) - \(requirement) - 不支持")
            }
        }
        
        // 检查分类类型支持
        print("\n--- 分类类型支持情况 ---")
        let categoryTypes: [(String, CategoryType, String)] = [
            ("基础类型", .sleepAnalysis, "所有iOS版本"),
            ("iOS 9.0+", .appleStandHour, "iOS 9.0+"),
            ("iOS 10.0+", .mindfulSession, "iOS 10.0+"),
            ("iOS 13.0+", .audioExposureEvent, "iOS 13.0+"),
            ("iOS 13.6+", .headache, "iOS 13.6+"),
            ("iOS 14.0+", .handwashingEvent, "iOS 14.0+"),
            ("iOS 14.3+", .contraceptive, "iOS 14.3+"),
            ("iOS 15.0+", .appleWalkingSteadinessEvent, "iOS 15.0+"),
            ("iOS 16.0+", .persistentIntermenstrualBleeding, "iOS 16.0+"),
            ("iOS 18.0+", .bleedingAfterPregnancy, "iOS 18.0+")
        ]
        
        for (name, type, requirement) in categoryTypes {
            if let original = type.original {
                print("✅ \(name): \(original) - \(requirement) - 支持")
            } else {
                print("❌ \(name): \(type) - \(requirement) - 不支持")
            }
        }
        
        // 检查当前可读和可写的类型数量
        print("\n--- 当前配置统计 ---")
        print("可读类型总数: \(typesToRead.count)")
        print("可写类型总数: \(typesToWrite.count)")
        
        let quantityReadTypes = typesToRead.filter { $0 is QuantityType }.count
        let categoryReadTypes = typesToRead.filter { $0 is CategoryType }.count
        let otherReadTypes = typesToRead.count - quantityReadTypes - categoryReadTypes
        
        print("可读数量类型: \(quantityReadTypes)")
        print("可读分类类型: \(categoryReadTypes)")
        print("其他可读类型: \(otherReadTypes)")
        
        // 按iOS版本统计可读类型
        print("\n--- 按iOS版本统计可读类型 ---")
        var versionStats: [String: Int] = [:]
        
        for type in typesToRead {
            if let quantityType = type as? QuantityType {
                let version = getVersionForQuantityType(quantityType)
                versionStats[version, default: 0] += 1
            } else if let categoryType = type as? CategoryType {
                let version = getVersionForCategoryType(categoryType)
                versionStats[version, default: 0] += 1
            }
        }
        
        for (version, count) in versionStats.sorted(by: { $0.key < $1.key }) {
            print("\(version): \(count) 个类型")
        }
        
        print("=== 检查完成 ===\n")
        
        // 验证所有QuantityType都有对应的版本信息
        print("=== 验证QuantityType版本信息完整性 ===")
        var missingQuantityTypes: [QuantityType] = []
        for type in QuantityType.allCases {
            let version = getVersionForQuantityType(type)
            if version.isEmpty {
                missingQuantityTypes.append(type)
            }
        }
        if missingQuantityTypes.isEmpty {
            print("✅ 所有QuantityType都有对应的版本信息")
        } else {
            print("❌ 以下QuantityType缺少版本信息:")
            for type in missingQuantityTypes {
                print("   - \(type)")
            }
        }
        
        // 验证所有CategoryType都有对应的版本信息
        print("\n=== 验证CategoryType版本信息完整性 ===")
        var missingCategoryTypes: [CategoryType] = []
        for type in CategoryType.allCases {
            let version = getVersionForCategoryType(type)
            if version.isEmpty {
                missingCategoryTypes.append(type)
            }
        }
        if missingCategoryTypes.isEmpty {
            print("✅ 所有CategoryType都有对应的版本信息")
        } else {
            print("❌ 以下CategoryType缺少版本信息:")
            for type in missingCategoryTypes {
                print("   - \(type)")
            }
        }
        
        print("\n=== 验证完成 ===\n")
    }
    
    // 辅助方法：获取数量类型的iOS版本要求
    private func getVersionForQuantityType(_ type: QuantityType) -> String {
        switch type {
        // 基础版本 - 所有iOS版本都支持
        case .stepCount, .heartRate, .bloodPressureSystolic, .bloodPressureDiastolic,
             .activeEnergyBurned, .basalEnergyBurned, .bloodAlcoholContent, .bloodGlucose,
             .bodyFatPercentage, .bodyMass, .bodyMassIndex, .bodyTemperature,
             .dietaryEnergyConsumed, .distanceCycling, .distanceWalkingRunning,
             .electrodermalActivity, .flightsClimbed, .forcedExpiratoryVolume1,
             .forcedVitalCapacity, .height, .inhalerUsage, .leanBodyMass, .nikeFuel,
             .numberOfTimesFallen, .oxygenSaturation, .peakExpiratoryFlowRate,
             .peripheralPerfusionIndex, .respiratoryRate,
             // 饮食相关的基础类型
             .dietaryBiotin, .dietaryCaffeine, .dietaryCalcium, .dietaryCarbohydrates,
             .dietaryChloride, .dietaryCholesterol, .dietaryChromium, .dietaryCopper,
             .dietaryFatMonounsaturated, .dietaryFatPolyunsaturated, .dietaryFatSaturated,
             .dietaryFatTotal, .dietaryFiber, .dietaryFolate, .dietaryIodine,
             .dietaryIron, .dietaryMagnesium, .dietaryManganese, .dietaryMolybdenum,
             .dietaryNiacin, .dietaryPantothenicAcid, .dietaryPhosphorus, .dietaryPotassium,
             .dietaryProtein, .dietaryRiboflavin, .dietarySelenium, .dietarySodium,
             .dietarySugar, .dietaryThiamin, .dietaryVitaminA, .dietaryVitaminB12,
             .dietaryVitaminB6, .dietaryVitaminC, .dietaryVitaminD, .dietaryVitaminE,
             .dietaryVitaminK, .dietaryZinc:
            return "基础版本"
            
        // iOS 9.0+ 支持的类型
        case .basalBodyTemperature, .uvExposure, .dietaryWater:
            return "iOS 9.0+"
            
        // iOS 9.3+ 支持的类型
        case .appleExerciseTime:
            return "iOS 9.3+"
            
        // iOS 10.0+ 支持的类型
        case .distanceSwimming, .distanceWheelchair, .swimmingStrokeCount, .pushCount:
            return "iOS 10.0+"
            
        // iOS 11.0+ 支持的类型
        case .insulinDelivery, .restingHeartRate, .walkingHeartRateAverage, .vo2Max, .waistCircumference,
             .heartRateVariabilitySDNN:
            return "iOS 11.0+"
            
        // iOS 11.2+ 支持的类型
        case .distanceDownhillSnowSports:
            return "iOS 11.2+"
            
        // iOS 13.0+ 支持的类型
        case .appleStandTime, .environmentalAudioExposure, .headphoneAudioExposure:
            return "iOS 13.0+"
            
        // iOS 14.0+ 支持的类型
        case .sixMinuteWalkTestDistance, .stairAscentSpeed, .stairDescentSpeed,
             .walkingAsymmetryPercentage, .walkingDoubleSupportPercentage, .walkingSpeed, .walkingStepLength:
            return "iOS 14.0+"
            
        // iOS 14.5+ 支持的类型
        case .appleMoveTime:
            return "iOS 14.5+"
            
        // iOS 15.0+ 支持的类型
        case .appleWalkingSteadiness, .numberOfAlcoholicBeverages:
            return "iOS 15.0+"
            
        // iOS 16.0+ 支持的类型
        case .appleSleepingWristTemperature, .atrialFibrillationBurden, .environmentalSoundReduction,
             .runningGroundContactTime, .runningPower, .runningSpeed, .runningStrideLength,
             .runningVerticalOscillation, .underwaterDepth, .waterTemperature,
             .heartRateRecoveryOneMinute:
            return "iOS 16.0+"
            
        // iOS 17.0+ 支持的类型
        case .cyclingCadence, .cyclingFunctionalThresholdPower, .cyclingPower, .cyclingSpeed,
             .physicalEffort, .timeInDaylight:
            return "iOS 17.0+"
            
        // iOS 18.0+ 支持的类型
        case .appleSleepingBreathingDisturbances, .crossCountrySkiingSpeed, .distanceCrossCountrySkiing,
             .distancePaddleSports, .distanceRowing, .distanceSkatingSports, .estimatedWorkoutEffortScore,
             .paddleSportsSpeed, .rowingSpeed, .workoutEffortScore:
            return "iOS 18.0+"
        }
    }
    
    // 辅助方法：获取分类类型的iOS版本要求
    private func getVersionForCategoryType(_ type: CategoryType) -> String {
        switch type {
        // 基础版本 - 所有iOS版本都支持
        case .sleepAnalysis:
            return "基础版本"
            
        // iOS 9.0+ 支持的类型
        case .appleStandHour, .cervicalMucusQuality, .intermenstrualBleeding, .menstrualFlow,
             .ovulationTestResult, .sexualActivity:
            return "iOS 9.0+"
            
        // iOS 10.0+ 支持的类型
        case .mindfulSession:
            return "iOS 10.0+"
            
        // iOS 12.2+ 支持的类型
        case .highHeartRateEvent, .irregularHeartRhythmEvent, .lowHeartRateEvent:
            return "iOS 12.2+"
            
        // iOS 13.0+ 支持的类型
        case .audioExposureEvent, .toothbrushingEvent:
            return "iOS 13.0+"
            
        // iOS 13.6+ 支持的类型
        case .abdominalCramps, .acne, .appetiteChanges, .bloating, .breastPain,
             .chestTightnessOrPain, .chills, .constipation, .coughing, .diarrhea,
             .dizziness, .fainting, .fatigue, .fever, .generalizedBodyAche,
             .headache, .heartburn, .hotFlashes, .lowerBackPain, .moodChanges,
             .nausea, .pelvicPain, .rapidPoundingOrFlutteringHeartbeat, .runnyNose,
             .shortnessOfBreath, .sinusCongestion, .skippedHeartbeat, .soreThroat,
             .vomiting, .wheezing, .lossOfSmell, .lossOfTaste, .sleepChanges:
            return "iOS 13.6+"
            
        // iOS 14.0+ 支持的类型
        case .drySkin, .environmentalAudioExposureEvent, .handwashingEvent, .nightSweats,
             .vaginalDryness, .memoryLapse, .bladderIncontinence, .hairLoss:
            return "iOS 14.0+"
            
        // iOS 14.2+ 支持的类型
        case .headphoneAudioExposureEvent:
            return "iOS 14.2+"
            
        // iOS 14.3+ 支持的类型
        case .contraceptive, .pregnancy, .lactation, .lowCardioFitnessEvent:
            return "iOS 14.3+"
            
        // iOS 15.0+ 支持的类型
        case .appleWalkingSteadinessEvent, .pregnancyTestResult, .progesteroneTestResult:
            return "iOS 15.0+"
            
        // iOS 16.0+ 支持的类型
        case .persistentIntermenstrualBleeding, .prolongedMenstrualPeriods,
             .irregularMenstrualCycles, .infrequentMenstrualCycles:
            return "iOS 16.0+"
            
        // iOS 18.0+ 支持的类型
        case .bleedingAfterPregnancy, .bleedingDuringPregnancy, .sleepApneaEvent:
            return "iOS 18.0+"
        }
    }
}
