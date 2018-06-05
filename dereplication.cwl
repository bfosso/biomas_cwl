#!/usr/bin/env cwl-runnercwlVersion: v1.0

cwlVersion: v1.0
class: CommandLineTool
label: "vsearch fastq2fasta conversion"
baseCommand: vsearch

hints:
  SoftwareRequirement:
    packages:
      vsearch:
        specs: [ "doi: 10.7717/peerj.2584 https://doi.org/10.7717/peerj.2584" ]
        version: [ "v2.7.0_linux_x86_64" ]

inputs:
  derep_full:
    type: File
    inputBinding:
      position: 1
      prefix: --derep_fulllength
      separate: true
  uc:
    type: string
    inputBinding:
      position: 2
      prefix: --uc
      separate: true
  log:
    type: string
    inputBinding:
      position: 3
      prefix: --log
      separate: true
  quiet:
    type: boolean
    inputBinding:
      position: 4
      prefix: --quiet
  threads:
    type: ["null", int]
    inputBinding:
      position: 5
      separate: true
      prefix: --threads


outputs:
  output_cluster:
    type: File
    outputBinding:
      glob: $(inputs.uc)
  log_file:
    type: File
    outputBinding:
      glob: $(inputs.log)
