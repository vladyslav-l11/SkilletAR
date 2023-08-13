//
//  ARViewContainer.swift
//  ScilletAR
//
//  Created by Vladyslav Lysenko on 16.07.2023.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true, bodySkeleton: nil, bodySkeletonAnchor: AnchorEntity())
        arView.setupForBodyTracking()
        arView.setupAnchor()
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        // Implemented wirh UIViewRepresentable
    }
}
