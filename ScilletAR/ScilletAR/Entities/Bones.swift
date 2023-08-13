//
//  Bones.swift
//  ScilletAR
//
//  Created by Vladyslav Lysenko on 16.07.2023.
//

import Foundation

enum Bones: CaseIterable {
    case leftShoulderToLeftArm
    case leftArmToLeftForearm
    case leftForearmToLeftHand

    case rightShoulderToRightArm
    case rightArmToRightForearm
    case rightForearmToRightHand

    case spine7ToLeftShoulder
    case spine7ToRightShoulder

    case neck1ToSpine7
    case spine7ToSpine6
    case spine6ToSpine5

    case hipsToLeftUpLeg
    case leftUpLegToLeftLeg
    case leftLegToLeftFoot

    case hipsToRightUpLeg
    case rightUpLegToRightLeg
    case rightLegToRightFoot

    var name: String {
        "\(jointFromName)-\(jointToName)"
    }

    var jointFromName: String {
        switch self {
        case .leftShoulderToLeftArm:
            return Localizable.leftShoulderJoint()
        case .leftArmToLeftForearm:
            return Localizable.leftArmJoint()
        case .leftForearmToLeftHand:
            return Localizable.leftForearmJoint()
        case .rightShoulderToRightArm:
            return Localizable.rightShoulderJoint()
        case .rightArmToRightForearm:
            return Localizable.rightArmJoint()
        case .rightForearmToRightHand:
            return Localizable.rightForearmJoint()
        case .spine7ToLeftShoulder, .spine7ToRightShoulder, .spine7ToSpine6:
            return Localizable.spine7Joint()
        case .neck1ToSpine7:
            return Localizable.neck1Joint()
        case .spine6ToSpine5:
            return Localizable.spine6Joint()
        case .hipsToLeftUpLeg, .hipsToRightUpLeg:
            return Localizable.hipsJoint()
        case .leftUpLegToLeftLeg:
            return Localizable.leftUpLegJoint()
        case .leftLegToLeftFoot:
            return Localizable.leftLegJoint()
        case .rightUpLegToRightLeg:
            return Localizable.rightUpLegJoint()
        case .rightLegToRightFoot:
            return Localizable.rightLegJoint()
        }
    }

    var jointToName: String {
        switch self {
        case .leftShoulderToLeftArm:
            return Localizable.leftArmJoint()
        case .leftArmToLeftForearm:
            return Localizable.leftForearmJoint()
        case .leftForearmToLeftHand:
            return Localizable.leftHandJoint()
        case .rightShoulderToRightArm:
            return Localizable.rightArmJoint()
        case .rightArmToRightForearm:
            return Localizable.rightForearmJoint()
        case .rightForearmToRightHand:
            return Localizable.rightHandJoint()
        case .spine7ToLeftShoulder:
            return Localizable.leftShoulderJoint()
        case .spine7ToRightShoulder:
            return Localizable.rightShoulderJoint()
        case .neck1ToSpine7:
            return Localizable.spine7Joint()
        case .spine7ToSpine6:
            return Localizable.spine6Joint()
        case .spine6ToSpine5:
            return Localizable.spine5Joint()
        case .hipsToLeftUpLeg:
            return Localizable.leftUpLegJoint()
        case .leftUpLegToLeftLeg:
            return Localizable.leftLegJoint()
        case .leftLegToLeftFoot:
            return Localizable.leftFootJoint()
        case .hipsToRightUpLeg:
            return Localizable.rightUpLegJoint()
        case .rightUpLegToRightLeg:
            return Localizable.rightLegJoint()
        case .rightLegToRightFoot:
            return Localizable.rightFootJoint()
        }
    }
}
