local args_string = [[
{
  "playback.props": {
    "node.name": "nr_output",
    "media.class": "Audio/Source"
  },
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
  "node.passive": true,
  "capture.props": {
    "node.name": "nr_input",
    "media.class": "Audio/Sink"
  },
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
