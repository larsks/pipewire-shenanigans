local args_string = [[
{
  "playback.props": {
    "node.name": "nr_output",
    "audio.channels": 2,
    "audio.position": [
      "FL",
      "FR"
    ],
    "media.class": "Audio/Source"
  },
  "node.description": "Noise Repellant (Stereo)",
  "capture.props": {
    "node.name": "nr_input",
    "audio.channels": 2,
    "audio.position": [
      "FL",
      "FR"
    ],
    "media.class": "Audio/Sink"
  },
  "audio.position": [
    "FL",
    "FR"
  ],
  "media.name": "Noise Repellant (Stereo)",
  "filter.graph": {
    "nodes": [
      {
        "plugin": "https://github.com/lucianodato/noise-repellent-stereo#new",
        "type": "lv2",
        "name": "nr",
        "control": {
          "smoothing": 30,
          "tonal_reduction": 50.000000,
          "adaptive_noise": 1,
          "adaptive_method": 0
        },
        "label": "noise-repellent-stereo"
      }
    ]
  },
  "audio.channels": 2,
  "node.passive": true
}
]]

local properties = {}
print("Loading module-filter-chain with arguments = ")
print(args_string)
filter_chain = LocalModule("libpipewire-module-filter-chain", args_string, properties)
