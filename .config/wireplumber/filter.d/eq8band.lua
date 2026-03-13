local args_string = [[
{
  "media.name": "Equalizer (8-band)",
  "filter.graph": {
    "nodes": [
      {
        "label": "eq8b",
        "plugin": "http://calf.sourceforge.net/plugins/Equalizer8Band",
        "type": "lv2",
        "name": "eq8b",
        "control": {
        }
      },
    ],
  },
  "capture.props": {
    "node.name": "eq8b.input",
    "media.class": "Audio/Sink"
  },
  "playback.props": {
    "node.name": "eq8b.output",
    "media.class": "Audio/Source"
  },
  "node.passive": true,
  "audio.position": [
    "MONO"
  ],
  "node.description": "Equalizer (8-band)",
  "audio.channels": 1
}
]]

local properties = {}
print("Loading module-filter-chain with arguments = ")
print(args_string)
filter_chain = LocalModule("libpipewire-module-filter-chain", args_string, properties)
