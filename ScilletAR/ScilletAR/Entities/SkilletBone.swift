//
//  SkilletBone.swift
//  ScilletAR
//
//  Created by Vladyslav Lysenko on 16.07.2023.
//

import Foundation
import RealityKit

struct SkilletBone {
    var fromJoint: SkilletJoint
    var toJoint: SkilletJoint
    
    var centerPosition: SIMD3<Float> {
        [
            (fromJoint.position.x + toJoint.position.x) / 2,
            (fromJoint.position.y + toJoint.position.y) / 2,
            (fromJoint.position.z + toJoint.position.z) / 2
        ]
    }
    
    var length: Float {
        simd_distance(fromJoint.position, toJoint.position)
    }
}
