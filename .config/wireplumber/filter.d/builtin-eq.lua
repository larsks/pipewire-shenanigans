local args_string = [[
{
  "filter.graph": {
    "links": [
      {
        "output": "eq_band_1:Out",
        "input": "eq_band_2:In"
      },
      {
        "output": "eq_band_2:Out",
        "input": "eq_band_3:In"
      },
      {
        "output": "eq_band_3:Out",
        "input": "eq_band_4:In"
      },
      {
        "output": "eq_band_4:Out",
        "input": "eq_band_5:In"
      },
      {
        "output": "eq_band_5:Out",
        "input": "eq_band_6:In"
      }
    ],
    "nodes": [
      {
        "name": "eq_band_1",
        "control": {
          "Gain": 0.000000,
          "Q": 1.000000,
          "Freq": 100.000000
        },
        "label": "bq_lowshelf",
        "type": "builtin"
      },
      {
        "name": "eq_band_2",
        "control": {
          "Gain": 0.000000,
          "Q": 1.000000,
          "Freq": 100.000000
        },
        "label": "bq_peaking",
        "type": "builtin"
      },
      {
        "name": "eq_band_3",
        "control": {
          "Gain": 0.000000,
          "Q": 1.000000,
          "Freq": 500.000000
        },
        "label": "bq_peaking",
        "type": "builtin"
      },
      {
        "name": "eq_band_4",
        "control": {
          "Gain": 0.000000,
          "Q": 1.000000,
          "Freq": 2000.000000
        },
        "label": "bq_peaking",
        "type": "builtin"
      },
      {
        "name": "eq_band_5",
        "control": {
          "Gain": 0.000000,
          "Q": 1.000000,
          "Freq": 5000.000000
        },
        "label": "bq_peaking",
        "type": "builtin"
      },
      {
        "name": "eq_band_6",
        "control": {
          "Gain": 0.000000,
          "Q": 1.000000,
          "Freq": 5000.000000
        },
        "label": "bq_highshelf",
        "type": "builtin"
      }
    ]
  },
  "playback.props": {
    "node.name": "mixer.output",
    "media.class": "Audio/Source"
  },
  "audio.position": [
    "FL",
    "FR"
  ],
  "capture.props": {
    "node.name": "mixer.input",
    "media.class": "Audio/Sink"
  },
  "audio.channels": 2,
  "media.name": "Equalizer (Builtin)",
  "node.description": "Equalizer (Builtin)"
}
]]

local properties = {}
print("Loading module-filter-chain with arguments = ")
print(args_string)
filter_chain = LocalModule("libpipewire-module-filter-chain", args_string, properties)
