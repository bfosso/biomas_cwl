#!/home/bfosso/miniconda2/bin/cwl-runner
cwlVersion: v1.0

class: CommandLineTool
label: "trim_galore"
baseCommand: trim_galore
requirements:
  InlineJavascriptRequirement: {}

hints:
  SoftwareRequirement:
    packages:
      fastqc:
        specs: ["www.bioinformatics.babraham.ac.uk/projects/trim_galore/" ]
        version: [ "0.4.4" ]

inputs:
  quality:
    type: int
    inputBinding:
      position: 1
      prefix: -q
  length:
    type: int
    inputBinding:
      position: 2
      prefix: --length
      separate: true
  stringency:
    type: int
    inputBinding:
      position: 3
      prefix: --stringency
      separate: true
  pair:
    type: boolean
    inputBinding:
      separate: true
      position: 4
      prefix: --paired
  zip:
    type: boolean
    inputBinding:
      position: 5
      prefix: --gzip
  R1:
    type: File
    inputBinding:
      position: 6
  R2:
    type: File
    inputBinding:
      position: 7

outputs:
  R1_trimmed:
    type: File
    outputBinding:
      #outputEval: $(inputs.R1).split(".fastq")[0] + "_val_1.fq.gz"
      glob: $((inputs.R1.basename).split(".fastq")[0]+"_val_1.fq.gz")
  R2_trimmed:
    type: File
    outputBinding:
      # outputEval: $(inputs.R2).split(".fastq")[0] + "_val_2.fq.gz"
      glob: $((inputs.R2.basename).split(".fastq")[0]+"_val_2.fq.gz")
