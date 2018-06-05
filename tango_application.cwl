#!/usr/bin/env cwl-runnercwlVersion: v1.0

cwlVersion: v1.0
class: CommandLineTool
label: "tango application"
baseCommand: tango.pl


inputs:
  ref_taxonomy:
    type: string
    inputBinding:
      position: 1
      prefix: --taxonomy
      separate: true
  input_matches:
    type: File
    inputBinding:
      position: 2
      prefix: --matches
      separate: true
  q_val:
    type: float
    inputBinding:
      position: 3
      prefix: --q-value
      separate: true
  outfile:
    type: string
    inputBinding:
      position: 4
      prefix: --output
      separate: true


outputs:
  assignment:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
