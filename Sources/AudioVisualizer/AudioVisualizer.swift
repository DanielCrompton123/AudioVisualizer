import SwiftUI
import Charts



public struct AudioVisualizer: View {
    
    // Initialise
    public var soundURL: URL
    public var updateInterval: Double
    public var numBars: Int
    public var magnitudeLimit: Float
    public var isPlaying: Bool
    
    @State private var amplitudes: [Float]
    private let audioProcessor: AudioProcessor
    
    public init(soundURL: URL,
                numBars: Int = 40,
                isPlaying: Bool = false,
                updateInterval: Double = 0.05,
                magnitudeLimit: Float = 40) {
        self.soundURL = soundURL
        self.updateInterval = updateInterval
        self.numBars = numBars
        self.magnitudeLimit = magnitudeLimit
        self.isPlaying = isPlaying
        
        self.amplitudes = Array(repeating: 0, count: numBars)
        self.audioProcessor = AudioProcessor(for: soundURL, withIntervals: numBars)
    }
    
    public var body: some View {
        
        // Timer used to update the UI
        let timerPublisher = Timer.publish(every: updateInterval, on: .main, in: .common).autoconnect()
        
        VStack {
            // SWIFT SHARTS CHART
            Chart(Array(amplitudes.enumerated()), id: \.offset) { index, magnitude in
                BarMark(
                    x: .value("Frequency", String(index)),
                    y: .value("Magnitude", magnitude)
                )
                .clipShape(Capsule())
            }
            .chartYScale(domain: 0...magnitudeLimit)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            
            // Update bar marks when the timer triggers
            .onReceive(timerPublisher, perform: updateData)
        }
        
    }
    
    private func updateData(_: Date) {
        if isPlaying {
            withAnimation(.easeOut(duration: 0.08)) {
                amplitudes = audioProcessor.fftMagnitudes.map {
                    min($0, magnitudeLimit)
                }
            }
        }
    }
}



@available(iOS 17.0, *)
#Preview {
    AudioVisualizer(soundURL: Bundle.module.url(forResource: "sample-music", withExtension: "mp3")!, numBars: 30)
}
