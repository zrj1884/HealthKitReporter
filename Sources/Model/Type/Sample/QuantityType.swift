//
//  QuantityType.swift
//  HealthKitReporter
//
//  Created by Victor on 05.10.20.
//

import HealthKit

/**
 All HealthKit quantity types
 */
public enum QuantityType: Int, CaseIterable, SampleType {
    case activeEnergyBurned
    case appleExerciseTime
    case appleMoveTime
    case appleSleepingBreathingDisturbances
    case appleSleepingWristTemperature
    case appleStandTime
    case appleWalkingSteadiness
    case atrialFibrillationBurden
    case basalBodyTemperature
    case basalEnergyBurned
    case bloodAlcoholContent
    case bloodGlucose
    case bloodPressureDiastolic
    case bloodPressureSystolic
    case bodyFatPercentage
    case bodyMass
    case bodyMassIndex
    case bodyTemperature
    case crossCountrySkiingSpeed
    case cyclingCadence
    case cyclingFunctionalThresholdPower
    case cyclingPower
    case cyclingSpeed
    case dietaryBiotin
    case dietaryCaffeine
    case dietaryCalcium
    case dietaryCarbohydrates
    case dietaryChloride
    case dietaryCholesterol
    case dietaryChromium
    case dietaryCopper
    case dietaryEnergyConsumed
    case dietaryFatMonounsaturated
    case dietaryFatPolyunsaturated
    case dietaryFatSaturated
    case dietaryFatTotal
    case dietaryFiber
    case dietaryFolate
    case dietaryIodine
    case dietaryIron
    case dietaryMagnesium
    case dietaryManganese
    case dietaryMolybdenum
    case dietaryNiacin
    case dietaryPantothenicAcid
    case dietaryPhosphorus
    case dietaryPotassium
    case dietaryProtein
    case dietaryRiboflavin
    case dietarySelenium
    case dietarySodium
    case dietarySugar
    case dietaryThiamin
    case dietaryVitaminA
    case dietaryVitaminB12
    case dietaryVitaminB6
    case dietaryVitaminC
    case dietaryVitaminD
    case dietaryVitaminE
    case dietaryVitaminK
    case dietaryWater
    case dietaryZinc
    case distanceCrossCountrySkiing
    case distanceCycling
    case distanceDownhillSnowSports
    case distancePaddleSports
    case distanceRowing
    case distanceSkatingSports
    case distanceSwimming
    case distanceWalkingRunning
    case distanceWheelchair
    case electrodermalActivity
    case environmentalAudioExposure
    case environmentalSoundReduction
    case estimatedWorkoutEffortScore
    case flightsClimbed
    case forcedExpiratoryVolume1
    case forcedVitalCapacity
    case headphoneAudioExposure
    case heartRate
    case heartRateRecoveryOneMinute
    case heartRateVariabilitySDNN
    case height
    case inhalerUsage
    case insulinDelivery
    case leanBodyMass
    case nikeFuel
    case numberOfAlcoholicBeverages
    case numberOfTimesFallen
    case oxygenSaturation
    case paddleSportsSpeed
    case peakExpiratoryFlowRate
    case peripheralPerfusionIndex
    case physicalEffort
    case pushCount
    case respiratoryRate
    case restingHeartRate
    case rowingSpeed
    case runningGroundContactTime
    case runningPower
    case runningSpeed
    case runningStrideLength
    case runningVerticalOscillation
    case sixMinuteWalkTestDistance
    case stairAscentSpeed
    case stairDescentSpeed
    case stepCount
    case swimmingStrokeCount
    case timeInDaylight
    case underwaterDepth
    case uvExposure
    case vo2Max
    case walkingAsymmetryPercentage
    case walkingDoubleSupportPercentage
    case walkingHeartRateAverage
    case walkingSpeed
    case walkingStepLength
    case waistCircumference
    case waterTemperature
    case workoutEffortScore

    public var identifier: String? {
        return original?.identifier
    }

    public var original: HKObjectType? {
        switch self {
        case .activeEnergyBurned:
            return HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
        case .appleExerciseTime:
            if #available(iOS 9.3, *) {
                return HKObjectType.quantityType(forIdentifier: .appleExerciseTime)
            }
        case .appleMoveTime:
            if #available(iOS 14.5, *) {
                return HKObjectType.quantityType(forIdentifier: .appleMoveTime)
            }
        case .appleSleepingBreathingDisturbances:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .appleSleepingBreathingDisturbances)
            }
        case .appleSleepingWristTemperature:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .appleSleepingWristTemperature)
            }
        case .appleStandTime:
            if #available(iOS 13.0, *) {
                return HKObjectType.quantityType(forIdentifier: .appleStandTime)
            }
        case .appleWalkingSteadiness:
            if #available(iOS 15.0, *) {
                return HKObjectType.quantityType(forIdentifier: .appleWalkingSteadiness)
            }
        case .atrialFibrillationBurden:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .atrialFibrillationBurden)
            }
        case .basalBodyTemperature:
            if #available(iOS 9.0, *) {
                return HKObjectType.quantityType(forIdentifier: .basalBodyTemperature)
            }
        case .basalEnergyBurned:
            return HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)
        case .bloodAlcoholContent:
            return HKObjectType.quantityType(forIdentifier: .bloodAlcoholContent)
        case .bloodGlucose:
            return HKObjectType.quantityType(forIdentifier: .bloodGlucose)
        case .bloodPressureDiastolic:
            return HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)
        case .bloodPressureSystolic:
            return HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)
        case .bodyFatPercentage:
            return HKObjectType.quantityType(forIdentifier: .bodyFatPercentage)
        case .bodyMass:
            return HKObjectType.quantityType(forIdentifier: .bodyMass)
        case .bodyMassIndex:
            return HKObjectType.quantityType(forIdentifier: .bodyMassIndex)
        case .bodyTemperature:
            return HKObjectType.quantityType(forIdentifier: .bodyTemperature)
        case .crossCountrySkiingSpeed:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .crossCountrySkiingSpeed)
            }
        case .cyclingCadence:
            if #available(iOS 17.0, *) {
                return HKObjectType.quantityType(forIdentifier: .cyclingCadence)
            }
        case .cyclingFunctionalThresholdPower:
            if #available(iOS 17.0, *) {
                return HKObjectType.quantityType(forIdentifier: .cyclingFunctionalThresholdPower)
            }
        case .cyclingPower:
            if #available(iOS 17.0, *) {
                return HKObjectType.quantityType(forIdentifier: .cyclingPower)
            }
        case .cyclingSpeed:
            if #available(iOS 17.0, *) {
                return HKObjectType.quantityType(forIdentifier: .cyclingSpeed)
            }
        case .dietaryBiotin:
            return HKObjectType.quantityType(forIdentifier: .dietaryBiotin)
        case .dietaryCaffeine:
            return HKObjectType.quantityType(forIdentifier: .dietaryCaffeine)
        case .dietaryCalcium:
            return HKObjectType.quantityType(forIdentifier: .dietaryCalcium)
        case .dietaryCarbohydrates:
            return HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates)
        case .dietaryChloride:
            return HKObjectType.quantityType(forIdentifier: .dietaryChloride)
        case .dietaryCholesterol:
            return HKObjectType.quantityType(forIdentifier: .dietaryCholesterol)
        case .dietaryChromium:
            return HKObjectType.quantityType(forIdentifier: .dietaryChromium)
        case .dietaryCopper:
            return HKObjectType.quantityType(forIdentifier: .dietaryCopper)
        case .dietaryEnergyConsumed:
            return HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)
        case .dietaryFatMonounsaturated:
            return HKObjectType.quantityType(forIdentifier: .dietaryFatMonounsaturated)
        case .dietaryFatPolyunsaturated:
            return HKObjectType.quantityType(forIdentifier: .dietaryFatPolyunsaturated)
        case .dietaryFatSaturated:
            return HKObjectType.quantityType(forIdentifier: .dietaryFatSaturated)
        case .dietaryFatTotal:
            return HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)
        case .dietaryFiber:
            return HKObjectType.quantityType(forIdentifier: .dietaryFiber)
        case .dietaryFolate:
            return HKObjectType.quantityType(forIdentifier: .dietaryFolate)
        case .dietaryIodine:
            return HKObjectType.quantityType(forIdentifier: .dietaryIodine)
        case .dietaryIron:
            return HKObjectType.quantityType(forIdentifier: .dietaryIron)
        case .dietaryMagnesium:
            return HKObjectType.quantityType(forIdentifier: .dietaryMagnesium)
        case .dietaryManganese:
            return HKObjectType.quantityType(forIdentifier: .dietaryManganese)
        case .dietaryMolybdenum:
            return HKObjectType.quantityType(forIdentifier: .dietaryMolybdenum)
        case .dietaryNiacin:
            return HKObjectType.quantityType(forIdentifier: .dietaryNiacin)
        case .dietaryPantothenicAcid:
            return HKObjectType.quantityType(forIdentifier: .dietaryPantothenicAcid)
        case .dietaryPhosphorus:
            return HKObjectType.quantityType(forIdentifier: .dietaryPhosphorus)
        case .dietaryPotassium:
            return HKObjectType.quantityType(forIdentifier: .dietaryPotassium)
        case .dietaryProtein:
            return HKObjectType.quantityType(forIdentifier: .dietaryProtein)
        case .dietaryRiboflavin:
            return HKObjectType.quantityType(forIdentifier: .dietaryRiboflavin)
        case .dietarySelenium:
            return HKObjectType.quantityType(forIdentifier: .dietarySelenium)
        case .dietarySodium:
            return HKObjectType.quantityType(forIdentifier: .dietarySodium)
        case .dietarySugar:
            return HKObjectType.quantityType(forIdentifier: .dietarySugar)
        case .dietaryThiamin:
            return HKObjectType.quantityType(forIdentifier: .dietaryThiamin)
        case .dietaryVitaminA:
            return HKObjectType.quantityType(forIdentifier: .dietaryVitaminA)
        case .dietaryVitaminB12:
            return HKObjectType.quantityType(forIdentifier: .dietaryVitaminB12)
        case .dietaryVitaminB6:
            return HKObjectType.quantityType(forIdentifier: .dietaryVitaminB6)
        case .dietaryVitaminC:
            return HKObjectType.quantityType(forIdentifier: .dietaryVitaminC)
        case .dietaryVitaminD:
            return HKObjectType.quantityType(forIdentifier: .dietaryVitaminD)
        case .dietaryVitaminE:
            return HKObjectType.quantityType(forIdentifier: .dietaryVitaminE)
        case .dietaryVitaminK:
            return HKObjectType.quantityType(forIdentifier: .dietaryVitaminK)
        case .dietaryWater:
            if #available(iOS 9.0, *) {
                return HKObjectType.quantityType(forIdentifier: .dietaryWater)
            }
        case .dietaryZinc:
            return HKObjectType.quantityType(forIdentifier: .dietaryZinc)
        case .distanceCrossCountrySkiing:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .distanceCrossCountrySkiing)
            }
        case .distanceCycling:
            return HKObjectType.quantityType(forIdentifier: .distanceCycling)
        case .distanceDownhillSnowSports:
            if #available(iOS 11.2, *) {
                return HKObjectType.quantityType(forIdentifier: .distanceDownhillSnowSports)
            }
        case .distancePaddleSports:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .distancePaddleSports)
            }
        case .distanceRowing:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .distanceRowing)
            }
        case .distanceSkatingSports:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .distanceSkatingSports)
            }
        case .distanceSwimming:
            if #available(iOS 10.0, *) {
                return HKObjectType.quantityType(forIdentifier: .distanceSwimming)
            }
        case .distanceWalkingRunning:
            return HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
        case .distanceWheelchair:
            if #available(iOS 10.0, *) {
                return HKObjectType.quantityType(forIdentifier: .distanceWheelchair)
            }
        case .electrodermalActivity:
            return HKObjectType.quantityType(forIdentifier: .electrodermalActivity)
        case .environmentalAudioExposure:
            if #available(iOS 13.0, *) {
                return HKObjectType.quantityType(forIdentifier: .environmentalAudioExposure)
            }
        case .environmentalSoundReduction:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .environmentalSoundReduction)
            }
        case .estimatedWorkoutEffortScore:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .estimatedWorkoutEffortScore)
            }
        case .flightsClimbed:
            return HKObjectType.quantityType(forIdentifier: .flightsClimbed)
        case .forcedExpiratoryVolume1:
            return HKObjectType.quantityType(forIdentifier: .forcedExpiratoryVolume1)
        case .forcedVitalCapacity:
            return HKObjectType.quantityType(forIdentifier: .forcedVitalCapacity)
        case .headphoneAudioExposure:
            if #available(iOS 13.0, *) {
                return HKObjectType.quantityType(forIdentifier: .headphoneAudioExposure)
            }
        case .heartRate:
            return HKObjectType.quantityType(forIdentifier: .heartRate)
        case .heartRateRecoveryOneMinute:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .heartRateRecoveryOneMinute)
            }
        case .heartRateVariabilitySDNN:
            if #available(iOS 11.0, *) {
                return HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)
            }
        case .height:
            return HKObjectType.quantityType(forIdentifier: .height)
        case .inhalerUsage:
            return HKObjectType.quantityType(forIdentifier: .inhalerUsage)
        case .insulinDelivery:
            if #available(iOS 11.0, *) {
                return HKObjectType.quantityType(forIdentifier: .insulinDelivery)
            }
        case .leanBodyMass:
            return HKObjectType.quantityType(forIdentifier: .leanBodyMass)
        case .nikeFuel:
            return HKObjectType.quantityType(forIdentifier: .nikeFuel)
        case .numberOfAlcoholicBeverages:
            if #available(iOS 15.0, *) {
                return HKObjectType.quantityType(forIdentifier: .numberOfAlcoholicBeverages)
            }
        case .numberOfTimesFallen:
            return HKObjectType.quantityType(forIdentifier: .numberOfTimesFallen)
        case .oxygenSaturation:
            return HKObjectType.quantityType(forIdentifier: .oxygenSaturation)
        case .paddleSportsSpeed:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .paddleSportsSpeed)
            }
        case .peakExpiratoryFlowRate:
            return HKObjectType.quantityType(forIdentifier: .peakExpiratoryFlowRate)
        case .peripheralPerfusionIndex:
            return HKObjectType.quantityType(forIdentifier: .peripheralPerfusionIndex)
        case .physicalEffort:
            if #available(iOS 17.0, *) {
                return HKObjectType.quantityType(forIdentifier: .physicalEffort)
            }
        case .pushCount:
            if #available(iOS 10.0, *) {
                return HKObjectType.quantityType(forIdentifier: .pushCount)
            }
        case .respiratoryRate:
            return HKObjectType.quantityType(forIdentifier: .respiratoryRate)
        case .restingHeartRate:
            if #available(iOS 11.0, *) {
                return HKObjectType.quantityType(forIdentifier: .restingHeartRate)
            }
        case .rowingSpeed:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .rowingSpeed)
            }
        case .runningGroundContactTime:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .runningGroundContactTime)
            }
        case .runningPower:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .runningPower)
            }
        case .runningSpeed:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .runningSpeed)
            }
        case .runningStrideLength:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .runningStrideLength)
            }
        case .runningVerticalOscillation:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .runningVerticalOscillation)
            }
        case .sixMinuteWalkTestDistance:
            if #available(iOS 14.0, *) {
                return HKObjectType.quantityType(forIdentifier: .sixMinuteWalkTestDistance)
            }
        case .stairAscentSpeed:
            if #available(iOS 14.0, *) {
                return HKObjectType.quantityType(forIdentifier: .stairAscentSpeed)
            }
        case .stairDescentSpeed:
            if #available(iOS 14.0, *) {
                return HKObjectType.quantityType(forIdentifier: .stairDescentSpeed)
            }
        case .stepCount:
            return HKObjectType.quantityType(forIdentifier: .stepCount)
        case .swimmingStrokeCount:
            if #available(iOS 10.0, *) {
                return HKObjectType.quantityType(forIdentifier: .swimmingStrokeCount)
            }
        case .timeInDaylight:
            if #available(iOS 17.0, *) {
                return HKObjectType.quantityType(forIdentifier: .timeInDaylight)
            }
        case .underwaterDepth:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .underwaterDepth)
            }
        case .uvExposure:
            if #available(iOS 9.0, *) {
                return HKObjectType.quantityType(forIdentifier: .uvExposure)
            }
        case .vo2Max:
            if #available(iOS 11.0, *) {
                return HKObjectType.quantityType(forIdentifier: .vo2Max)
            }
        case .walkingAsymmetryPercentage:
            if #available(iOS 14.0, *) {
                return HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)
            }
        case .walkingDoubleSupportPercentage:
            if #available(iOS 14.0, *) {
                return HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)
            }
        case .walkingHeartRateAverage:
            if #available(iOS 11.0, *) {
                return HKObjectType.quantityType(forIdentifier: .walkingHeartRateAverage)
            }
        case .walkingSpeed:
            if #available(iOS 14.0, *) {
                return HKObjectType.quantityType(forIdentifier: .walkingSpeed)
            }
        case .walkingStepLength:
            if #available(iOS 14.0, *) {
                return HKObjectType.quantityType(forIdentifier: .walkingStepLength)
            }
        case .waistCircumference:
            if #available(iOS 11.0, *) {
                return HKObjectType.quantityType(forIdentifier: .waistCircumference)
            }
        case .waterTemperature:
            if #available(iOS 16.0, *) {
                return HKObjectType.quantityType(forIdentifier: .waterTemperature)
            }
        case .workoutEffortScore:
            if #available(iOS 18.0, *) {
                return HKObjectType.quantityType(forIdentifier: .workoutEffortScore)
            }
        }
        return nil
    }
}
