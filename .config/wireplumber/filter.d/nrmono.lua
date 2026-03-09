local args_string = [[
{
  "media.name": "Noise Repellant (Mono)",
  "filter.graph": {
    "nodes": [
      {
        "label": "noise-repellent-mono",
        "plugin": "https://github.com/lucianodato/noise-repellent#new",
        "type": "lv2",
        "name": "nr",
        "control": {
          "smoothing": 30,
          "adaptive_method": 0,
          "adaptive_noise": 1,
          "tonal_reduction": 50.000000
        }
      }
    ]
  },
  "capture.props": {
    "node.name": "nr_mono.input",
    "media.class": "Audio/Sink"
  },
  "playback.props": {
    "node.name": "nr_mono.output",
    "media.class": "Audio/Source"
  },
  "node.passive": true,
  "audio.position": [
    "FL"
  ],
  "node.description": "Noise Repellant (Mono)",
  "audio.channels": 1
}
]]

local properties = {}
print("Loading module-filter-chain with arguments = ")
print(args_string)
filter_chain = LocalModule("libpipewire-module-filter-chain", args_string, properties)
