local args_string = [[
{
  "media.name": "Equalizer (12-band)",
  "filter.graph": {
    "nodes": [
      {
        "label": "eq12b",
        "plugin": "http://calf.sourceforge.net/plugins/Equalizer12Band",
        "type": "lv2",
        "name": "eq12b",
        "control": {
		"p1_active": 1,
		"p2_active": 1,
		"p3_active": 1,
		"p4_active": 1,
		"p5_active": 1,
		"p6_active": 1,
		"p7_active": 1,
		"p8_active": 1,
		"lp_active": 1,
		"hp_active": 1,
		"hp_freq": 300.0,
		"lp_freq": 4000.0,
		"level_in": 6.0,
		"p4_level": 2.0
        }
      },
    ],
  },
  "capture.props": {
    "node.name": "eq12b.input",
    "media.class": "Audio/Sink"
  },
  "playback.props": {
    "node.name": "eq12b.output",
    "media.class": "Audio/Source"
  },
  "node.passive": true,
  "audio.position": [
    "MONO"
  ],
  "node.description": "Equalizer (12-band)",
  "audio.channels": 1
}
]]

local properties = {}
print("Loading module-filter-chain with arguments = ")
print(args_string)
filter_chain = LocalModule("libpipewire-module-filter-chain", args_string, properties)
