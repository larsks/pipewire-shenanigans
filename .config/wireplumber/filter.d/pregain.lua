local args_string = [[
{
  "media.name": "Pre Gain (Mono)",
  "filter.graph": {
    "nodes": [
      {
        "type": "builtin",
        "name": "pregain",
        "label": "mixer",
        "control": {
          "Gain 1": 1
        }
      }
    ],
    "inputs": [ "pregain:In 1" ],
    "outputs": [ "pregain:Out" ]
  },
  "capture.props": {
    "node.name": "pregain.input",
    "media.class": "Audio/Sink"
  },
  "playback.props": {
    "node.name": "pregain.output",
    "media.class": "Audio/Source"
  },
  "node.passive": true,
  "audio.position": [ "MONO" ],
  "node.description": "Pre Gain (Mono)",
  "audio.channels": 1
}
]]
local properties = {}
filter_chain = LocalModule("libpipewire-module-filter-chain", args_string, properties)
