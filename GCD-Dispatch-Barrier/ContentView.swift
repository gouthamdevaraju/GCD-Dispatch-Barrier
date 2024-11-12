//
//  ContentView.swift
//  GCD-Dispatch-Barrier
//
//  Created by Goutham Devaraju on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Trigger GCD Barrier - Demo") {
                GCD_Barrier()
            }.padding()
        }
        .padding()
    }
    
    func GCD_Barrier() {
        
        let queue = DispatchQueue(label: "com.goutham.barrierExample", attributes: .concurrent)
        
        var sharedResource = [String]()
        
        for i in 1...5 {
            queue.async {
                print("Reading task: \(i), Shared Resources: \(sharedResource)")
            }
        }
        
        queue.async(flags: .barrier) {
            sharedResource.append("Adding new element to the shared resource using a barrier.")
            print("This is a writing task: Added a new task data")
        }
        
        for i in 6...10 {
            queue.async {
                print("Reading task: \(i), Shared Resources: \(sharedResource)")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("Final Shared Resource: \(sharedResource)")
        }
    }
}

#Preview {
    ContentView()
}
