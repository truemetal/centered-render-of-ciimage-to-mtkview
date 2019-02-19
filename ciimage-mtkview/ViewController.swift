//
//  ViewController.swift
//  ciimage-mtkview
//
//  Created by Bogdan Pashchenko on 2/19/19.
//  Copyright © 2019 com.ios-engineer. All rights reserved.
//

import UIKit
import MetalKit
import CoreImage

class ViewController: UIViewController {
    
    var metalView: MTKView { return view as! MTKView }
    let device = MTLCreateSystemDefaultDevice()!
    var commandQueue: MTLCommandQueue!
    var context: CIContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = CIContext(mtlDevice: device, options: [.priorityRequestLow: NSNumber(booleanLiteral: true)])
        commandQueue = device.makeCommandQueue()!
        metalView.framebufferOnly = false
        metalView.device = device
        metalView.delegate = self
    }
    
    let image: CIImage! = CIFilter(name: "CICheckerboardGenerator")?.outputImage?.cropped(to: CGRect(x: 0, y: 0, width: 500, height: 500))
}

extension ViewController: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        let buffer = commandQueue.makeCommandBuffer()!
        let drawable = view.currentDrawable!
        
        let centered = image.transformed(by: CGAffineTransform(translationX: (view.drawableSize.width - image.extent.width) / 2, y: (view.drawableSize.height - image.extent.height) / 2))
        context.render(centered, to: drawable.texture, commandBuffer: buffer, bounds: centered.extent, colorSpace: CGColorSpaceCreateDeviceRGB())
        
        buffer.present(drawable)
        buffer.commit()
    }
}
