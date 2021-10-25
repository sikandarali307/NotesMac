//
//  BlurView.swift
//  NotesMac (iOS)
//
//  Created by Mac on 25/10/2021.
//

import SwiftUI
//since app supported ios 14
struct BlurView : UIViewRepresentable {
    var style : UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
         
    }
    
}
 
