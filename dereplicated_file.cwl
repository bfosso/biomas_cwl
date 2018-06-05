#!/usr/bin/env cwl-runnercwlVersion: v1.0

cwlVersion: v1.0
class: CommandLineTool
label: "Dereplicated fastq file generation"
baseCommand: dereplicate_file_creation.py

hints:
  SoftwareRequirement:
    packages:
      python:
        specs: [ "https://www.python.org" ]
        version: [ "2.7" ]
      biopython:
        specs: [ "https://biopython.org" ]
        version: [ "1.70" ]
      numpy:
        specs: [ "http://www.numpy.org" ]
        version: [ "1.12.1" ]

inputs:
  fastq_file:
    type: File
    inputBinding:
      position: 1
      prefix: -f
      separate: true
  prefix:
    type: string
    inputBinding:
      position: 2
      prefix: -p
      separate: true
  ucfile:
    type: File
    inputBinding:
      position: 3
      prefix: -u
      separate: true

outputs:
  output_fastq:
      type: File
      outputBinding:
        glob: $(inputs.prefix)_dereplicated_consensus.fastq
