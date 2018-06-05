#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: "bowtie2 execution script: Paired-Ends mode"
baseCommand: bowtie2

hints:
  SoftwareRequirement:
    packages:
      bowtie2:
        specs: [ "http://bowtie-bio.sourceforge.net/bowtie2/index.shtml" ]
        version: [ "2.3.4.1" ]

inputs:
  fastq_flag:
    type: boolean
    inputBinding:
      position: 1
      prefix: -q
  seed_n:
    type: int
    inputBinding:
      position: 2
      separate: false
      prefix: -N
  index_loc:
    type: Any
    inputBinding:
      position: 4
      prefix: -x
      separate: true
  match_n:
    type: int
    inputBinding:
      prefix: -k
      separate: false
      position: 3
  input_PE_R1_fastq:
    type: File
    inputBinding:
      prefix: "-1"
      separate: true
      itemSeparator: ","
      position: 5
  input_PE_R2_fastq:
    type: File
    inputBinding:
      prefix: "-2"
      separate: true
      itemSeparator: ","
      position: 6
  output_sam:
    type: string
    inputBinding:
      prefix: -S
      separate: true
      position: 8
  processors:
    type: int
    inputBinding:
      prefix: -p
      separate: true
      position: 7
  local_alignment:
    type: boolean
    inputBinding:
      position: 9
      prefix: --local
  unaligned_items:
    type: boolean
    inputBinding:
      position: 10
      prefix: --no-unal

outputs:
  output_file_sam:
    type: File
    outputBinding:
      glob: $(inputs.output_sam)
