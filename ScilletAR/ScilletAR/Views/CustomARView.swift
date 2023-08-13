//
//  CustomARView.swift
//  ScilletAR
//
//  Created by Vladyslav Lysenko on 19.07.2023.
//

import RealityKit
import ARKit

final class CustomARView: ARView {
    private var bodySkeleton: BodySkeleton?
    private var bodySkeletonAnchor: AnchorEntity?
    
    init(frame frameRect: CGRect, cameraMode: ARView.CameraMode, automaticallyConfigureSession: Bool, bodySkeleton: BodySkeleton?, bodySkeletonAnchor: AnchorEntity) {
        super.init(frame: frameRect, cameraMode: cameraMode, automaticallyConfigureSession: automaticallyConfigureSession)
        self.bodySkeleton = bodySkeleton
        self.bodySkeletonAnchor = bodySkeletonAnchor
    }
    
    func setupAnchor() {
        bodySkeletonAnchor.flatMap { scene.addAnchor($0) }
    }
    
    required dynamic init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    required dynamic init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
}

extension CustomARView: ARSessionDelegate {
    func setupForBodyTracking() {
        let configuration = ARBodyTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        configuration.frameSemantics.insert(.bodyDetection)
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        session.delegate = self
    }

    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let bodyAnchor = anchor as? ARBodyAnchor else { return }
            if let skeleton = bodySkeleton {
                skeleton.update(with: bodyAnchor)
            } else {
                bodySkeleton = BodySkeleton(for: bodyAnchor)
                bodySkeleton.flatMap { [weak self] in self?.bodySkeletonAnchor?.addChild($0) }
            }
        }
    }
}
