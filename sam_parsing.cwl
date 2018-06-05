#!/usr/bin/env cwl-runnercwlVersion: v1.0

cwlVersion: v1.0
class: CommandLineTool
label: "Dereplicated fastq file generation"
baseCommand: sam_parsing.py

hints:
  SoftwareRequirement:
    packages:
      python:
        specs: [ "https://www.python.org" ]
        version: [ "2.7" ]
      pysam:
        specs: [ "http://pysam.readthedocs.io/en/latest/#" ]
        version: [ "0.11.2.2" ]
      numpy:
        specs: [ "http://www.numpy.org" ]
        version: [ "1.12.1" ]

inputs:
  pe_no_uncl:
    type: File
    inputBinding:
      position: 1
      prefix: -p
      separate: true
  pe_no_uncl:
    type: File
    inputBinding:
      position: 2
      prefix: -u
      separate: true
  se_no_uncl:
    type: File
    inputBinding:
      position: 3
      prefix: -s
      separate: true
  se_uncl:
    type: File
    inputBinding:
      position: 4
      prefix: -t
  nodes_file:
    type: string
    inputBinding:
      position: 5
      prefix: -v

outputs:
  over_97:
    type: File
    outputBinding:
      glob: over_97_dump_data
  under_97:
    type: File
    outputBinding:
      glob: under_97_dump_data
