//
//  BodySkillet.swift
//  ScilletAR
//
//  Created by Vladyslav Lysenko on 16.07.2023.
//

import RealityKit
import ARKit

class BodySkeleton: Entity {
    var joints: [String: Entity] = [:]
    var bones: [String: Entity] = [:]

    var headParts: [String] {
        [
            Localizable.neck1Joint(),
            Localizable.neck2Joint(),
            Localizable.neck3Joint(),
            Localizable.neck4Joint(),
            Localizable.headJoint(),
            Localizable.leftShoulderJoint(),
            Localizable.rightShoulderJoint()
        ]
    }

    var topBodyParts: [String] {
        [
            Localizable.jawJoint(),
            Localizable.chinJoint(),
            Localizable.leftEyeJoint(),
            Localizable.leftEyeLowerLidJoint(),
            Localizable.leftEyeUpperLidJoint(),
            Localizable.leftEyeballJoint(),
            Localizable.noseJoint(),
            Localizable.rightEyeJoint(),
            Localizable.rightEyeLowerLidJoint(),
            Localizable.rightEyeUpperLidJoint(),
            Localizable.rightEyeballJoint()
        ]
    }

    var handParts: [String] {
        [
            Localizable.leftHandJoint(),
            Localizable.rightHandJoint()
        ]
    }

    required init(for bodyAnchor: ARBodyAnchor) {
        super.init()

        for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
            var jointRadius: Float = 0.05
            let jointColor: UIColor = .white

            switch jointName {
            case _ where headParts.contains(where: { $0 == jointName }):
                jointRadius *= 0.5
            case _ where topBodyParts.contains(where: { $0 == jointName }):
                jointRadius *= 0.2
            case _ where jointName.hasPrefix(Localizable.spine()):
                jointRadius *= 0.75
            case _ where handParts.contains(where: { $0 == jointName }):
                jointRadius *= 1
            case _ where jointName.hasPrefix(Localizable.leftHand())
                || jointName.hasPrefix(Localizable.rightHand()):
                jointRadius *= 0.25
            case _ where jointName.hasPrefix(Localizable.leftToes())
                || jointName.hasPrefix(Localizable.rightToes()):
                jointRadius *= 0.5
            default:
                jointRadius = 0.05
            }

            let jointEntity = createJoint(radius: jointRadius, color: jointColor)
            joints[jointName] = jointEntity
            addChild(jointEntity)
        }

        for bone in Bones.allCases {
            guard let skeletonBone = createSkeletonBone(bone: bone, bodyAnchor: bodyAnchor) else {
                continue
            }
            let boneEntity = createBonentity(for: skeletonBone)
            bones[bone.name] = boneEntity
            addChild(boneEntity)
        }
    }

    required init() {
        print("init() has not been implemented")
    }

    func update(with bodyAnchor: ARBodyAnchor) {
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        
        for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
            guard let jointEntity = joints[jointName],
                  let jointEntityTransform = bodyAnchor.skeleton
                .modelTransform(for: ARSkeleton.JointName(rawValue: jointName)) else {
                return
            }
            let jointEntityOffsetFromRoot = simd_make_float3(jointEntityTransform.columns.3)
            jointEntity.position = jointEntityOffsetFromRoot + rootPosition
            jointEntity.orientation = Transform(matrix: jointEntityTransform).rotation
        }

        for bone in Bones.allCases {
            guard let entity = bones[bone.name],
                  let skeletonBone = createSkeletonBone(bone: bone, bodyAnchor: bodyAnchor) else {
                continue
            }
            entity.position = skeletonBone.centerPosition
            entity.look(at: skeletonBone.toJoint.position,
                        from: skeletonBone.centerPosition,
                        relativeTo: nil)
        }
    }

    private func createJoint(radius: Float, color: UIColor = .white) -> Entity {
        let mesh = MeshResource.generateSphere(radius: radius)
        let material = SimpleMaterial(color: color, roughness: 0.8, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }

    private func createSkeletonBone(bone: Bones, bodyAnchor: ARBodyAnchor) -> SkilletBone? {
        guard let fromJointEntityTransform = bodyAnchor.skeleton
            .modelTransform(for: ARSkeleton.JointName(rawValue: bone.jointFromName)),
              let toJointEntityTransform = bodyAnchor.skeleton
            .modelTransform(for: ARSkeleton.JointName(rawValue: bone.jointToName)) else {
            return nil
        }

        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        let jointFromEntityOffsetFromRoot = simd_make_float3(fromJointEntityTransform.columns.3)
        let jointFromEntityPosition = jointFromEntityOffsetFromRoot + rootPosition
        let jointToEntityOffsetFromRoot = simd_make_float3(toJointEntityTransform.columns.3)
        let jointToEntityPosition = jointToEntityOffsetFromRoot + rootPosition

        let fromJoint = SkilletJoint(name: bone.jointFromName, position: jointFromEntityPosition)
        let toJoint = SkilletJoint(name: bone.jointToName, position: jointToEntityPosition)
        return SkilletBone(fromJoint: fromJoint, toJoint: toJoint)
    }

    private func createBonentity(for skilletBone: SkilletBone, diameter: Float = 0.04, color: UIColor = .white) -> Entity {
        let mesh = MeshResource.generateBox(size: [diameter, diameter, skilletBone.length],
                                            cornerRadius: diameter / 2)
        let material = SimpleMaterial(color: color, roughness: 0.5, isMetallic: true)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }
}
