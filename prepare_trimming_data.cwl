#!/home/bfosso/miniconda2/bin/cwl-runner
cwlVersion: v1.0

class: CommandLineTool
label: "prepare data for trimming"
baseCommand: clean_merging_data.py

hints:
  SoftwareRequirement:
    packages:
      python:
        specs: [ "https://www.python.org" ]
        version: [ "2.7" ]

inputs:
  prefisso:
    type: string
    inputBinding:
      separate: true
      position: 1
      prefix: -p
  forward:
    type: string
    inputBinding:
      separate: true
      position: 2
      prefix: -f
  reverse:
    type: string
    inputBinding:
      prefix: -r
      separate: true
      position: 3
  merged:
    type: File
    inputBinding:
      prefix: -m
      separate: true
      position: 4



outputs:
  # output:
  #     type:
  #       type: array
  #       items: File
  #     outputBinding:
  #       # glob: "*.fastq"
  #       glob: $(inputs.prefisso)*
  R1_unmerged:
    type: File
    outputBinding:
      glob: $(inputs.prefisso).unmerged_R1.fastq
  R2_unmerged:
    type: File
    outputBinding:
      glob: $(inputs.prefisso).unmerged_R2.fastq
