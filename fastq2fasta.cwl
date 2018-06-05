#!/usr/bin/env cwl-runnercwlVersion: v1.0

cwlVersion: v1.0
class: CommandLineTool
label: "vsearch fastq2fasta conversion"
baseCommand: vsearch

hints:
  SoftwareRequirement:
    packages:
      fastqc:
        specs: [ "doi: 10.7717/peerj.2584 https://doi.org/10.7717/peerj.2584" ]
        version: [ "v2.7.0_linux_x86_64" ]

inputs:
  filter_fastq:
    type: File
    inputBinding:
      position: 1
      prefix: --fastq_filter
      separate: true
  fasta:
    type: string
    inputBinding:
      position: 2
      prefix: --fastaout
      separate: true
  min_fastq_length:
    type: ["null", int]
    inputBinding:
      position: 3
      prefix: --fastq_minlen
      separate: true


outputs:
  output_fasta:
      type: File
      outputBinding:
        glob: $(inputs.fasta)
