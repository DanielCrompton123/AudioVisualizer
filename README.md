#  AudioVisualizer

This is a simple package including an `AudioVisualizer` that's used to draw a graph of audio frequency versus magnitude.

<hr>
### This code comes from Vinicius Nakamura's video How FAST is Swift Charts? [Can it handle a sound visualizer? - SwiftUI - iOS 16](https://www.youtube.com/watch?v=8kX1CX-ujlA).

**Thanks so much to Vinicius for this code!**
<hr>

## Usage

Create an `AudioVisualizer` view and pass in:

- a **music file URL** -- required (e.g. mp3, wav etc.)
- a number of bars (default 40)
- an update interval -- How often the graph is updated; **the lower, the more often it will refresh** but the more battery life your app uses. The higher, the less reactive the visualizer is.
- a boolean property to indicate wether the player is playing or not
- the highest magnitude before the graph saturates.

## License

Use as you like
